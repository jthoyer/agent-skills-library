const { chromium } = require('playwright');
const S = process.argv[2];
const URL_ = 'http://localhost:8765/boltresults.html?view=timing&race=1';
const r = (id, number, name, predictedSec, wave = null) => ({ id, number, name, predictedSec, wave, finishAt: null });
function dbWith(race1) { const races = {}; for (let n = 1; n <= 5; n++) races[n] = { racers: [], waveStarts: {}, wavesLocked: false, prizes: [] }; races[1] = Object.assign(races[1], race1); return { races }; }
const field = [r('a', 1, 'Justin H', 1201), r('b', 2, 'Fiona Horn', 1770), r('c', 3, 'Sam Slow', 2400)];
let blocked = 0;
async function page(browser, db, { width = 1024, ui = { resultsView: 'timing', race: 1 } } = {}) {
  const ctx = await browser.newContext({ viewport: { width, height: 900 } }); // fresh context = fresh storage
  await ctx.route(/script\.google/, route => { blocked++; route.abort(); });
  const p = await ctx.newPage();
  const errors = []; p.on('pageerror', e => errors.push(e.message)); p.on('console', m => { if (m.type() === 'error' && !/Failed to load|ERR_FAILED|net::/.test(m.text())) errors.push(m.text()); });
  p.on('dialog', d => d.accept());
  await p.addInitScript(([db, ui]) => { if (!sessionStorage.getItem('seeded')) { localStorage.setItem('balance-timing-v2', JSON.stringify(db)); localStorage.setItem('balance-timing-ui-v2', JSON.stringify(ui)); sessionStorage.setItem('seeded', '1'); } window.__said = []; document.addEventListener('DOMContentLoaded', () => { new MutationObserver(() => { const t = document.querySelector('#announcer').textContent; if (t) window.__said.push(t); }).observe(document.querySelector('#announcer'), { childList: true, characterData: true, subtree: true }); }); }, [db, ui]);
  await p.goto(URL_); await p.waitForTimeout(600);
  return { p, ctx, errors };
}
const bars = p => p.$$eval('.wave-bar', els => els.map(b => ({ cls: b.className, h: b.querySelector('h3').textContent, clock: b.querySelector('.wave-clock').innerText.replace(/\s+/g,' ').trim(), note: (b.querySelector('.wave-nudge-note') || {}).textContent || null, names: [...b.parentElement.querySelectorAll('.roster-name')].map(n => n.textContent) })));
const ok = (c, m) => { console.log((c ? 'ok   ' : 'FAIL ') + m); if (!c) process.exitCode = 1; };
(async () => {
  const browser = await chromium.launch();
  // A: pre-gun, unlocked
  { const { p, ctx, errors } = await page(browser, dbWith({ racers: field }));
    const b = await bars(p); console.log(JSON.stringify(b));
    ok(b[0].names[0] === 'Sam Slow' && b[2].names[0] === 'Justin H', 'A: wave 1 is the slowest call, last wave the quickest');
    ok(b[0].clock === 'On the line' && b[1].clock === 'Goes 10:30 after wave 1' && b[2].clock === 'Goes 19:59 after wave 1', 'A: planned gaps before the gun');
    ok(errors.length === 0, 'A: no page errors ' + errors.join('|'));
    await p.screenshot({ path: S + '/A-pregun.png', fullPage: true }); await ctx.close(); }
  // B: wave 1 went 5 minutes ago
  { const now = Date.now(); const { p, ctx, errors } = await page(browser, dbWith({ racers: field.map((x, i) => ({ ...x, wave: 3 - i })), wavesLocked: true, waveStarts: { 1: now - 300000 } }));
    let b = await bars(p); console.log(JSON.stringify(b));
    ok(/^Start in (5:2\d|5:30)$/.test(b[1].clock), 'B: wave 2 counts down ~5:30 (' + b[1].clock + ')');
    ok(/^Start in 14:5\d$/.test(b[2].clock), 'B: wave 3 counts down ~14:59 (' + b[2].clock + ')');
    ok(b[0].cls.includes('running') && !b[0].note, 'B: wave 1 running, no nudge row');
    const live = await p.$eval('#waveControls', el => el.closest('[aria-live]') ? 'IN LIVE REGION' : 'none');
    ok(live === 'none', 'B: countdown not inside a live region');
    // C: nudge
    await p.click('[data-focus-key="nudge:2:later"]'); await p.waitForTimeout(300);
    b = await bars(p);
    ok(b[1].note === 'Nudged +0:30' && /^Start in (5:5\d|6:00)$/.test(b[1].clock), 'C: +30s moves wave 2 only (' + b[1].clock + ', ' + b[1].note + ')');
    ok(/^Start in 14:5\d$/.test(b[2].clock), 'C: wave 3 unmoved');
    const ann = await p.waitForFunction(() => document.querySelector('#announcer').textContent, null, { timeout: 2000 }).then(h => h.jsonValue());
    ok(/Wave 2 nudged \+0:30\. Start in/.test(ann), 'C: announced once: ' + ann);
    await p.waitForTimeout(4500); // outlasts a render cycle
    const focus = await p.evaluate(() => document.activeElement.dataset.focusKey);
    ok(focus === 'nudge:2:later', 'C: focus stays on +30s (' + focus + ')');
    await p.screenshot({ path: S + '/C-nudged.png', fullPage: true });
    await p.click('[data-focus-key="nudge:2:reset"]'); await p.waitForTimeout(300);
    b = await bars(p);
    ok(b[1].note === 'On plan', 'C: reset puts it back on plan');
    ok(await p.evaluate(() => document.activeElement.dataset.focusKey) === 'nudge:2:later', 'C: focus lands on +30s after Reset vanishes');
    // reload keeps nudge
    await p.click('[data-focus-key="nudge:2:earlier"]'); await p.reload(); await p.waitForTimeout(600);
    b = await bars(p); ok(b[1].note === 'Nudged −0:30', 'C: nudge survives reload');
    ok(errors.length === 0, 'B/C: no page errors ' + errors.join('|')); await ctx.close(); }
  // D: overdue, then start via button
  { const now = Date.now(); const { p, ctx, errors } = await page(browser, dbWith({ racers: field.map((x, i) => ({ ...x, wave: 3 - i })), wavesLocked: true, waveStarts: { 1: now - 700000 } }), { width: 375 });
    await p.waitForTimeout(500);
    let b = await bars(p); console.log(JSON.stringify(b));
    ok(b[1].clock === 'Start now' && b[1].cls.includes('due'), 'D: overdue wave says Start now and has .due');
    ok(!b[2].cls.includes('due'), 'D: wave 3 not due');
    const label = await p.$eval('.wave-bar.due .wave-count-label', el => getComputedStyle(el).display);
    ok(label === 'none', 'D: "Start in" label hidden when due');
    await p.waitForTimeout(4500); const said = await p.evaluate(() => window.__said);
    ok(said.filter(t => t === 'Wave 2: start now.').length === 1, 'D: due announced exactly once across re-renders: ' + JSON.stringify(said));
    ok(!(await bars(p))[1].h.includes('3') , 'D: sanity');
    await p.screenshot({ path: S + '/D-due-375.png', fullPage: true });
    const started = await p.$$eval('.start-button', els => els.map(e => e.textContent));
    ok(started.length === 2, 'D: Start buttons still present for waves 2 and 3 (never auto-started)');
    await p.click('text=Start wave 2'); await p.waitForTimeout(400);
    b = await bars(p);
    ok(b[1].cls.includes('running') && /^\d+:\d\d$/.test(b[1].clock) && !b[1].note, 'D: started wave shows running clock, no countdown ' + b[1].clock);
    ok(/^Start in/.test(b[2].clock), 'D: wave 3 still counting to the first gun');
    // widths
    const overflow = await p.evaluate(() => document.documentElement.scrollWidth > innerWidth);
    ok(!overflow, 'D: no horizontal overflow at 375px');
    const sizes = await p.$$eval('.nudge-button', els => els.map(e => { const r = e.getBoundingClientRect(); return [Math.round(r.width), Math.round(r.height)]; }));
    ok(sizes.every(([w, h]) => w >= 44 && h >= 44), 'D: nudge buttons >= 44px ' + JSON.stringify(sizes));
    ok(errors.length === 0, 'D: no page errors ' + errors.join('|')); await ctx.close(); }
  // E: crossing zero live (run on its own fresh context, after D, i.e. order independent)
  { const now = Date.now(); const { p, ctx, errors } = await page(browser, dbWith({ racers: field.map((x, i) => ({ ...x, wave: 3 - i })), wavesLocked: true, waveStarts: { 1: now - 630000 + 3000 } }));
    let b = await bars(p); ok(/^Start in 0:0[123]$/.test(b[1].clock) && !b[1].cls.includes('due'), 'E: counting down the last seconds ' + b[1].clock);
    await p.waitForTimeout(8000);
    b = await bars(p); const said = await p.evaluate(() => window.__said);
    ok(b[1].clock === 'Start now' && b[1].cls.includes('due'), 'E: flips to Start now at zero');
    ok(said.filter(t => t === 'Wave 2: start now.').length === 1, 'E: announced exactly once: ' + JSON.stringify(said));
    ok(b[1].cls.includes('pending') && (await p.$$('.start-button')).length === 2, 'E: still not started — never auto-starts');
    await p.screenshot({ path: S + '/E-due.png', fullPage: true });
    ok(errors.length === 0, 'E: no page errors'); await ctx.close(); }
  console.log('requests to Apps Script aborted:', blocked);
  await browser.close();
})();
