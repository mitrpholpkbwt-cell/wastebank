<!DOCTYPE html>
<html lang="th">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<title>ฝากขยะออนไลน์ ♻️</title>
<link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@400;500;600;700&family=Prompt:wght@600;700&display=swap" rel="stylesheet">
<style>
:root{
  --g1:#0a5230;--g2:#1a7a4a;--g3:#2db868;
  --gl:#dff2e9;--gll:#f0faf4;
  --txt:#111f18;--txt2:#3d6650;--txt3:#7aa88c;
  --brd:#b8ddc8;--bg:#f4f9f6;--wh:#fff;
  --rad:18px;--rad-sm:12px;
  --shad:0 2px 20px rgba(10,82,48,.10);
  --gold:#d4a017;--gold-l:#fff8e7;--gold-b:#f5e0a0;
}
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent}
html{scroll-behavior:smooth}
body{font-family:'Sarabun',sans-serif;background:var(--bg);color:var(--txt);min-height:100vh;padding-bottom:60px}

/* HERO HEADER */
.hero{background:var(--g1);padding:22px 20px 20px;text-align:center;position:relative;overflow:hidden}
.hero::before{content:'';position:absolute;top:-50px;right:-50px;width:180px;height:180px;border-radius:50%;background:rgba(255,255,255,.05)}
.hero::after{content:'';position:absolute;bottom:-40px;left:-30px;width:130px;height:130px;border-radius:50%;background:rgba(255,255,255,.04)}
.hero-ic{font-size:48px;display:block;margin-bottom:8px;position:relative;z-index:1}
.hero-title{font-family:'Prompt',sans-serif;font-size:20px;font-weight:700;color:#fff;margin-bottom:4px;position:relative;z-index:1}
.hero-sub{font-size:13px;color:rgba(255,255,255,.65);position:relative;z-index:1}

/* FLOW INDICATOR */
.flow{display:flex;align-items:center;justify-content:center;background:var(--wh);border-bottom:1px solid var(--brd);padding:12px 16px;gap:6px}
.flow-step{display:flex;align-items:center;gap:6px}
.flow-dot{width:26px;height:26px;border-radius:50%;border:2px solid var(--brd);background:var(--wh);display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;color:var(--txt3);transition:all .3s;flex-shrink:0}
.flow-dot.on{background:var(--g2);border-color:var(--g2);color:#fff;box-shadow:0 0 0 3px rgba(26,122,74,.18)}
.flow-dot.done{background:var(--gl);border-color:var(--g2);color:var(--g2)}
.flow-lbl{font-size:12px;font-weight:600;color:var(--txt3);transition:color .2s}
.flow-lbl.on{color:var(--g2)}
.flow-lbl.done{color:var(--g2)}
.flow-arr{color:var(--brd);font-size:14px;font-weight:700;transition:color .2s}
.flow-arr.done{color:var(--g3)}

/* MAIN */
.main{max-width:480px;margin:0 auto;padding:18px 15px 0}

/* PAGE */
.page{display:none;animation:up .28s ease both}
.page.on{display:block}
@keyframes up{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}

/* SECTION */
.sec{background:var(--wh);border:1px solid var(--brd);border-radius:var(--rad);padding:20px;margin-bottom:14px;box-shadow:var(--shad)}
.sec-hd{display:flex;align-items:center;gap:10px;margin-bottom:16px}
.sec-ic{width:42px;height:42px;border-radius:var(--rad-sm);background:var(--gl);display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0}
.sec-title{font-family:'Prompt',sans-serif;font-size:15px;font-weight:700;color:var(--g1)}
.sec-sub{font-size:12px;color:var(--txt3);margin-top:2px}

/* WASTE GRID — individual weight inputs */
.wgrid{display:flex;flex-direction:column;gap:10px}

.witem{position:relative}
.witem input[type=checkbox]{position:absolute;opacity:0;width:0;height:0}

.witem label.wlabel{
  display:flex;align-items:center;gap:12px;
  padding:13px 14px;border:1.5px solid var(--brd);
  border-radius:var(--rad-sm);cursor:pointer;
  font-size:14px;font-weight:500;color:var(--txt2);
  background:var(--wh);transition:all .2s;
  user-select:none;
}
.witem label.wlabel .em{font-size:26px;flex-shrink:0}
.witem label.wlabel .wname{flex:1}
.witem label.wlabel .wprice-tag{font-size:11px;color:var(--txt3);font-weight:600;background:var(--gll);border:1px solid var(--brd);border-radius:20px;padding:2px 9px;white-space:nowrap}

.witem input[type=checkbox]:checked + label.wlabel{border-color:var(--g2);background:var(--gl);color:var(--g1);font-weight:700}
.witem input[type=checkbox]:checked + label.wlabel .em{transform:scale(1.1)}
.witem input[type=checkbox]:checked + label.wlabel .wprice-tag{background:var(--g2);color:#fff;border-color:var(--g2)}

/* Per-item weight row */
.witem-detail{
  display:none;
  background:var(--gll);border:1.5px solid var(--g3);border-top:none;
  border-radius:0 0 var(--rad-sm) var(--rad-sm);
  padding:10px 14px 12px;
  margin-top:-4px;
}
.witem-detail.show{display:flex;align-items:center;gap:10px;animation:up .22s ease both}
.wdet-lbl{font-size:12px;font-weight:700;color:var(--g2);white-space:nowrap}
.wdet-input{flex:1;padding:8px 12px;border:1.5px solid var(--brd);border-radius:var(--rad-sm);font-family:'Sarabun',sans-serif;font-size:15px;font-weight:700;color:var(--txt);background:var(--wh);outline:none;transition:border-color .2s;text-align:center}
.wdet-input:focus{border-color:var(--g3);box-shadow:0 0 0 3px rgba(45,184,104,.15)}
.wdet-unit{font-size:13px;font-weight:700;color:var(--txt3);white-space:nowrap}
.wdet-sub{font-size:11px;color:var(--g2);text-align:right;margin-top:4px}

/* PRICE PREVIEW BOX */
.price-box{
  background:linear-gradient(135deg,#0a5230 0%,#1a7a4a 100%);
  border-radius:var(--rad);padding:18px 20px;margin-bottom:14px;
  box-shadow:0 4px 24px rgba(10,82,48,.25);
  position:relative;overflow:hidden;
}
.price-box::before{content:'💰';position:absolute;right:16px;top:50%;transform:translateY(-50%);font-size:52px;opacity:.15}
.price-box-lbl{font-size:12px;font-weight:700;color:rgba(255,255,255,.65);letter-spacing:.5px;margin-bottom:4px}
.price-box-total{font-family:'Prompt',sans-serif;font-size:36px;font-weight:700;color:#fff;line-height:1}
.price-box-unit{font-size:14px;color:rgba(255,255,255,.7);margin-left:4px}
.price-box-rows{margin-top:12px;border-top:1px solid rgba(255,255,255,.18);padding-top:10px;display:flex;flex-direction:column;gap:5px}
.pb-row{display:flex;justify-content:space-between;align-items:center;font-size:13px;color:rgba(255,255,255,.8)}
.pb-row-val{font-weight:700;color:#fff}
.pb-row.zero{opacity:.45}
.pb-empty{font-size:13px;color:rgba(255,255,255,.5);text-align:center;padding:6px 0}

/* WEIGHT ROW (name + total weight estimate) */
.wt-row{display:flex;gap:10px;align-items:center;margin-top:16px;padding-top:16px;border-top:1px solid var(--brd)}
.wt-label{font-size:13px;font-weight:700;color:var(--txt2);white-space:nowrap}
.wt-input{flex:1;padding:11px 14px;border:1.5px solid var(--brd);border-radius:var(--rad-sm);font-family:'Sarabun',sans-serif;font-size:16px;color:var(--txt);background:var(--wh);outline:none;transition:border-color .2s,box-shadow .2s;text-align:center;font-weight:600}
.wt-input:focus{border-color:var(--g3);box-shadow:0 0 0 3px rgba(45,184,104,.15)}
.wt-unit{background:var(--gl);color:var(--g1);font-size:14px;font-weight:700;padding:11px 16px;border-radius:var(--rad-sm);border:1.5px solid var(--brd);white-space:nowrap}

/* NOTE */
.note-row{margin-top:14px;padding-top:14px;border-top:1px solid var(--brd)}
.note-label{font-size:12px;font-weight:700;color:var(--txt3);margin-bottom:6px;display:block}
textarea{width:100%;padding:11px 14px;border:1.5px solid var(--brd);border-radius:var(--rad-sm);font-family:'Sarabun',sans-serif;font-size:14px;color:var(--txt);background:var(--wh);outline:none;resize:vertical;min-height:64px;transition:border-color .2s}
textarea:focus{border-color:var(--g3);box-shadow:0 0 0 3px rgba(45,184,104,.15)}

/* UPLOAD */
.upzone{
  border:2.5px dashed var(--brd);border-radius:var(--rad);
  padding:30px 16px;text-align:center;cursor:pointer;
  background:var(--gll);position:relative;transition:all .22s;
}
.upzone:hover,.upzone.drag{border-color:var(--g3);background:var(--gl)}
.upzone input{position:absolute;inset:0;opacity:0;cursor:pointer;width:100%}
.up-ic{font-size:44px;display:block;margin-bottom:10px}
.up-main{font-size:15px;font-weight:700;color:var(--g2);margin-bottom:4px}
.up-sub{font-size:12px;color:var(--txt3)}

.prevs{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;margin-top:12px}
.prev{aspect-ratio:1;border-radius:var(--rad-sm);overflow:hidden;position:relative;border:1.5px solid var(--brd)}
.prev img{width:100%;height:100%;object-fit:cover;display:block}
.prev .del{position:absolute;top:5px;right:5px;width:22px;height:22px;border-radius:50%;background:rgba(0,0,0,.65);color:#fff;border:none;cursor:pointer;font-size:10px;font-weight:700;display:flex;align-items:center;justify-content:center}
.pcnt{text-align:right;font-size:12px;color:var(--txt3);margin-top:6px}

/* SUMMARY */
.sum-list{display:flex;flex-direction:column;gap:0}
.srow{display:flex;justify-content:space-between;align-items:flex-start;padding:9px 0;border-bottom:1px solid var(--gl);font-size:14px}
.srow:last-child{border:none}
.sk{color:var(--txt2)}
.sv{font-weight:700;color:var(--txt);text-align:right;max-width:60%}
.sv.money{color:var(--g1);font-size:16px}

/* TOTAL in summary */
.sum-total{background:var(--gl);border-radius:var(--rad-sm);padding:13px 16px;margin-top:12px;display:flex;justify-content:space-between;align-items:center;border:1px solid var(--brd)}
.sum-total-lbl{font-size:14px;font-weight:700;color:var(--g2)}
.sum-total-val{font-family:'Prompt',sans-serif;font-size:22px;font-weight:700;color:var(--g1)}

/* BUTTONS */
.brow{display:flex;gap:10px;margin-top:4px}
.btn{flex:1;padding:15px;border:none;border-radius:var(--rad-sm);font-family:'Sarabun',sans-serif;font-size:15px;font-weight:700;cursor:pointer;transition:all .22s}
.btn-p{background:var(--g2);color:#fff}
.btn-p:hover{background:var(--g1);transform:translateY(-1px);box-shadow:0 5px 18px rgba(10,82,48,.28)}
.btn-p:active,.btn-p:disabled{transform:none;box-shadow:none}
.btn-p:disabled{background:#a0c8b0;cursor:not-allowed}
.btn-s{background:var(--gl);color:var(--g1);border:1.5px solid var(--brd);flex:0 0 auto;padding:15px 18px}
.btn-s:hover{background:#cce8d8}

/* SUCCESS */
.done-wrap{text-align:center;padding:36px 12px 16px}
.done-ic{font-size:68px;display:block;margin-bottom:14px;animation:pop .55s cubic-bezier(.36,.07,.19,.97) both}
@keyframes pop{0%{transform:scale(.2)}65%{transform:scale(1.18)}100%{transform:scale(1)}}
.done-title{font-family:'Prompt',sans-serif;font-size:22px;font-weight:700;color:var(--g1);margin-bottom:8px}
.done-sub{font-size:14px;color:var(--txt2);line-height:1.75;margin-bottom:22px}
.refbox{background:var(--gl);border-radius:var(--rad-sm);padding:16px;border:1px solid var(--brd);margin-bottom:16px}
.reflbl{font-size:11px;font-weight:700;color:var(--g2);letter-spacing:.5px;margin-bottom:5px}
.refnum{font-family:'Prompt',sans-serif;font-size:28px;font-weight:700;color:var(--g1);letter-spacing:4px}

/* EARN HIGHLIGHT in success */
.earn-box{background:linear-gradient(135deg,#0a5230,#1a7a4a);border-radius:var(--rad-sm);padding:16px;margin-bottom:14px;text-align:center}
.earn-lbl{font-size:12px;color:rgba(255,255,255,.7);margin-bottom:4px;font-weight:600}
.earn-val{font-family:'Prompt',sans-serif;font-size:32px;font-weight:700;color:#fff}

/* LOADING */
.ld{display:none;position:fixed;inset:0;background:rgba(10,82,48,.92);z-index:999;flex-direction:column;align-items:center;justify-content:center;gap:18px}
.ld.on{display:flex}
.spin{width:50px;height:50px;border:4px solid rgba(255,255,255,.2);border-top-color:#fff;border-radius:50%;animation:spin .7s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.ld-txt{color:#fff;font-size:16px;font-weight:600}
.ld-sub{font-size:13px;color:rgba(255,255,255,.6)}
</style>
</head>
<body>

<div class="hero">
  <span class="hero-ic">♻️</span>
  <div class="hero-title">ฝากขยะออนไลน์</div>
  <div class="hero-sub">เลือกประเภท · ถ่ายรูป · ส่งได้เลย</div>
</div>

<div class="flow" id="flow">
  <div class="flow-step">
    <div class="flow-dot on" id="fd1">1</div>
    <div class="flow-lbl on" id="fl1">เลือกขยะ</div>
  </div>
  <div class="flow-arr" id="fa1">›</div>
  <div class="flow-step">
    <div class="flow-dot" id="fd2">2</div>
    <div class="flow-lbl" id="fl2">ถ่ายรูป</div>
  </div>
  <div class="flow-arr" id="fa2">›</div>
  <div class="flow-step">
    <div class="flow-dot" id="fd3">3</div>
    <div class="flow-lbl" id="fl3">ยืนยัน</div>
  </div>
</div>

<div class="main">

  <!-- PAGE 1: เลือกขยะ -->
  <div class="page on" id="p1">

    <!-- PRICE LIVE PREVIEW -->
    <div class="price-box" id="pricebox">
      <div class="price-box-lbl">💵 ยอดรวมสะสมที่จะได้รับ</div>
      <div>
        <span class="price-box-total" id="pb-total">0.00</span>
        <span class="price-box-unit">บาท</span>
      </div>
      <div id="pb-prev-row" style="display:none;margin-top:6px">
        <span style="font-size:12px;color:rgba(255,255,255,.65)">ยอดก่อนหน้า <span id="pb-prev">0.00</span> บ. + รายการนี้ <span id="pb-cur">0.00</span> บ.</span>
      </div>
      <div class="price-box-rows" id="pb-rows">
        <div class="pb-empty">เลือกประเภทขยะและกรอกน้ำหนักเพื่อดูราคา</div>
      </div>
    </div>

    <div class="sec">
      <div class="sec-hd">
        <div class="sec-ic">🗑️</div>
        <div>
          <div class="sec-title">เลือกประเภทขยะ</div>
          <div class="sec-sub">เลือกและกรอกน้ำหนักแต่ละประเภท</div>
        </div>
      </div>

      <div class="wgrid" id="wgrid">
        <!-- Items injected by JS -->
      </div>

      <div class="wt-row">
        <span class="wt-label">ชื่อผู้ฝาก</span>
        <input class="wt-input" type="text" id="u-name" placeholder="กรอกชื่อ">
      </div>

      <div class="brow" style="margin-top:18px">
        <button class="btn btn-p" onclick="goP2()">ถ่ายรูปขยะ →</button>
      </div>
    </div>
  </div>

  <!-- PAGE 2: ถ่ายรูป -->
  <div class="page" id="p2">
    <div class="sec">
      <div class="sec-hd">
        <div class="sec-ic">📷</div>
        <div>
          <div class="sec-title">ถ่ายรูปขยะ</div>
          <div class="sec-sub">ถ่ายให้เห็นตัวเลขบนเครื่องชั่งให้ชัดเจน · สูงสุด 5 รูป</div>
        </div>
      </div>

      <div class="upzone" id="upzone">
        <input type="file" accept="image/*" multiple onchange="addPhotos(this.files)">
        <span class="up-ic">📸</span>
        <div class="up-main">แตะเพื่อถ่ายรูป</div>
        <div class="up-sub">หรือเลือกจากคลัง · JPG/PNG ไม่เกิน 5 MB</div>
      </div>
      <div class="prevs" id="prevs"></div>
      <div class="pcnt" id="pcnt"></div>
    </div>

    <div class="sec">
      <div class="sec-hd">
        <div class="sec-ic">✅</div>
        <div>
          <div class="sec-title">สรุปรายการ</div>
          <div class="sec-sub">ตรวจสอบก่อนกดส่งค่ะ</div>
        </div>
      </div>
      <div class="sum-list" id="sumbox"></div>
      <div class="brow" style="margin-top:18px">
        <button class="btn btn-s" onclick="goP1()">← แก้ไข</button>
        <button class="btn btn-p" id="sbtn" onclick="submit()">ส่งข้อมูล ✓</button>
      </div>
    </div>
  </div>

  <!-- PAGE 3: SUCCESS -->
  <div class="page" id="p3">
    <div class="sec">
      <div class="done-wrap">
        <span class="done-ic">🎉</span>
        <div class="done-title">ส่งเรียบร้อยแล้วค่ะ!</div>
        <div class="done-sub">รูปและข้อมูลถูกบันทึกแล้ว<br>เจ้าหน้าที่จะติดต่อกลับเร็วๆ นี้ค่ะ</div>
        <div class="refbox">
          <div class="reflbl">เลขอ้างอิง</div>
          <div class="refnum" id="refnum">WD000000</div>
        </div>
        <div class="earn-box">
          <div class="earn-lbl">💰 ยอดสะสมรวมทั้งหมด</div>
          <div class="earn-val" id="done-earn">0.00 บาท</div>
          <div id="done-earn-sub" style="font-size:12px;color:rgba(255,255,255,.65);margin-top:4px"></div>
        </div>
        <div class="sum-list" id="done-sum"></div>
        <button class="btn btn-p" style="width:100%;margin-top:20px" onclick="reset()">ฝากรายการใหม่</button>
      </div>
    </div>
  </div>

</div>

<!-- LOADING -->
<div class="ld" id="ld">
  <div class="spin"></div>
  <div class="ld-txt" id="ld-txt">กำลังส่งข้อมูล...</div>
  <div class="ld-sub" id="ld-sub">กรุณารอสักครู่ค่ะ</div>
</div>

<script>
// ════════════════════════════════════════
const GAS_URL = "https://script.google.com/macros/s/AKfycbwdbiMUK-vb29BxQI0gIfnZVFTY7GLblxlkv9a-y9df8A5sQwswYVnDu1_XZ7oHN-lW/exec";
// ════════════════════════════════════════

// Waste types with price per kg
const WASTE_TYPES = [
  { id:'w1', emoji:'📄', name:'กระดาษขาวดำ/สี',     value:'กระดาษขาวดำ/สี',       price: 1   },
  { id:'w2', emoji:'📦', name:'กระดาษแข็ง (ลัง)',    value:'กระดาษแข็ง (ลัง)',      price: 2   },
  { id:'w3', emoji:'🍾', name:'ขวดแก้ว',             value:'ขวดแก้ว',               price: 0.5 },
  { id:'w4', emoji:'🧴', name:'ขวดพลาสติก PET',      value:'ขวดพลาสติก',            price: 4   },
  { id:'w5', emoji:'🥫', name:'กระป๋องอลูมิเนียม',   value:'กระป๋องอลูมิเนียม',     price: 50  },
];

let photos = [];
let sessionTotal = 0;

/* ─ BUILD WASTE GRID ─ */
function buildGrid(){
  const grid = el('wgrid');
  grid.innerHTML = WASTE_TYPES.map(w => `
    <div class="witem">
      <input type="checkbox" id="${w.id}" value="${w.value}" onchange="toggleDetail('${w.id}')">
      <label class="wlabel" for="${w.id}">
        <span class="em">${w.emoji}</span>
        <span class="wname">${w.name}</span>
        <span class="wprice-tag">${formatPrice(w.price)} บ./กก.</span>
      </label>
      <div class="witem-detail" id="det-${w.id}">
        <span class="wdet-lbl">น้ำหนัก</span>
        <input class="wdet-input" type="text" inputmode="decimal" maxlength="8"
          id="wt-${w.id}" placeholder="0.0" oninput="calcPrice()">
        <span class="wdet-unit">กก.</span>
      </div>
    </div>
  `).join('');
}

function formatPrice(n){ return n % 1 === 0 ? n.toString() : n.toFixed(1); }

function toggleDetail(id){
  const cb  = el(id);
  const det = el('det-'+id);
  if(cb.checked){
    det.classList.add('show');
    el('wt-'+id).focus();
  } else {
    det.classList.remove('show');
    el('wt-'+id).value = '';
  }
  calcPrice();
}

/* ─ LIVE PRICE CALCULATION ─ */
function calcPrice(){
  let cur = 0;
  const lines = [];
  WASTE_TYPES.forEach(w => {
    const cb = el(w.id);
    if(!cb || !cb.checked) return;
    const wt = parseFloat(el('wt-'+w.id).value) || 0;
    const sub = wt * w.price;
    cur += sub;
    lines.push({ emoji: w.emoji, name: w.name, wt, price: w.price, sub });
  });

  const grand = sessionTotal + cur;
  el('pb-total').textContent = grand.toFixed(2);

  // show breakdown row only when there is a previous session
  const prevRow = el('pb-prev-row');
  if(sessionTotal > 0){
    prevRow.style.display = 'block';
    el('pb-prev').textContent = sessionTotal.toFixed(2);
    el('pb-cur').textContent  = cur.toFixed(2);
  } else {
    prevRow.style.display = 'none';
  }

  const rowsEl = el('pb-rows');
  if(lines.length === 0){
    rowsEl.innerHTML = '<div class="pb-empty">เลือกประเภทขยะและกรอกน้ำหนักเพื่อดูราคา</div>';
    return;
  }
  rowsEl.innerHTML = lines.map(l =>
    `<div class="pb-row${l.wt===0?' zero':''}">
       <span>${l.emoji} ${l.name} ${l.wt>0?l.wt+' กก.':'(ยังไม่ระบุน้ำหนัก)'}</span>
       <span class="pb-row-val">${l.sub.toFixed(2)} บ.</span>
     </div>`
  ).join('');
}

/* ─ TOTAL WEIGHT & AMOUNT HELPERS ─ */
function getTotalWeight(){
  return WASTE_TYPES.reduce((sum, w) => {
    const cb = el(w.id);
    if(!cb || !cb.checked) return sum;
    return sum + (parseFloat(el('wt-'+w.id).value) || 0);
  }, 0);
}

function getTotalAmount(){
  return WASTE_TYPES.reduce((sum, w) => {
    const cb = el(w.id);
    if(!cb || !cb.checked) return sum;
    const wt = parseFloat(el('wt-'+w.id).value) || 0;
    return sum + wt * w.price;
  }, 0);
}

function getItemizedText(){
  return WASTE_TYPES
    .filter(w => el(w.id) && el(w.id).checked)
    .map(w => {
      const wt = parseFloat(el('wt-'+w.id).value) || 0;
      return `${w.value} ${wt} กก. = ${(wt*w.price).toFixed(2)} บ.`;
    }).join(' | ');
}

function getSelectedSummary(){
  return WASTE_TYPES
    .filter(w => el(w.id) && el(w.id).checked)
    .map(w => ({
      name: w.name,
      emoji: w.emoji,
      wt: parseFloat(el('wt-'+w.id).value) || 0,
      price: w.price,
      sub: (parseFloat(el('wt-'+w.id).value)||0) * w.price
    }));
}

/* ─ FLOW ─ */
function setFlow(n) {
  [1,2,3].forEach(i=>{
    const d=el('fd'+i), l=el('fl'+i);
    d.className='flow-dot'+(i<n?' done':i===n?' on':'');
    l.className='flow-lbl'+(i<n?' done':i===n?' on':'');
  });
  [1,2].forEach(i=>{
    el('fa'+i).className='flow-arr'+(i<n?' done':'');
  });
  el('flow').style.display = n > 3 ? 'none' : 'flex';
}

function goP2(){
  if(!val()) return;
  renderSum();
  show('p2'); setFlow(2); scrollTop();
}
function goP1(){ show('p1'); setFlow(1); scrollTop(); }
function show(id){
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('on'));
  el(id).classList.add('on');
}
function scrollTop(){ window.scrollTo({top:0,behavior:'smooth'}); }

/* ─ VALIDATION ─ */
function val(){
  const items = getSelectedSummary();
  if(!items.length){ alert('กรุณาเลือกประเภทขยะอย่างน้อย 1 รายการค่ะ'); return false; }
  const noWt = items.filter(i => i.wt <= 0);
  if(noWt.length){
    alert(`กรุณาระบุน้ำหนักของ: ${noWt.map(i=>i.name).join(', ')} ค่ะ`);
    return false;
  }
  return true;
}

/* ─ PHOTOS ─ */
function addPhotos(files){
  for(const f of files){
    if(photos.length>=5){ alert('แนบได้สูงสุด 5 รูปค่ะ'); break; }
    if(f.size>5*1024*1024){ alert(`"${f.name}" ขนาดเกิน 5 MB ค่ะ`); continue; }
    const r=new FileReader();
    r.onload=e=>{ photos.push({name:f.name,type:f.type,dataUrl:e.target.result}); renderPrev(); };
    r.readAsDataURL(f);
  }
}
function renderPrev(){
  el('prevs').innerHTML=photos.map((p,i)=>
    `<div class="prev"><img src="${p.dataUrl}" loading="lazy"><button class="del" onclick="delP(${i})">✕</button></div>`
  ).join('');
  el('pcnt').textContent=photos.length?`${photos.length} / 5 รูป`:'';
}
function delP(i){ photos.splice(i,1); renderPrev(); }

const uz=el('upzone');
uz.addEventListener('dragover',e=>{e.preventDefault();uz.classList.add('drag');});
uz.addEventListener('dragleave',()=>uz.classList.remove('drag'));
uz.addEventListener('drop',e=>{e.preventDefault();uz.classList.remove('drag');addPhotos(e.dataTransfer.files);});

/* ─ SUMMARY (page 2) ─ */
function renderSum(){
  const items = getSelectedSummary();
  const total = getTotalAmount();
  const totalWt = getTotalWeight();

  let rows = [
    ['👤 ชื่อผู้ฝาก', g('u-name') || '-'],
    ['📷 รูปที่แนบ', photos.length+' รูป'],
  ];

  let html = rows.map(([k,v])=>
    `<div class="srow"><span class="sk">${k}</span><span class="sv">${esc(v)}</span></div>`
  ).join('');

  // itemized
  html += items.map(i =>
    `<div class="srow">
       <span class="sk">${i.emoji} ${i.name}<br><small style="color:var(--txt3);font-weight:400">${i.wt} กก. × ${formatPrice(i.price)} บ./กก.</small></span>
       <span class="sv">${i.sub.toFixed(2)} บาท</span>
     </div>`
  ).join('');

  html += `<div class="sum-total">
    <span class="sum-total-lbl">💰 รวมทั้งหมด (${totalWt.toFixed(2)} กก.)</span>
    <span class="sum-total-val">${total.toFixed(2)} บาท</span>
  </div>`;

  el('sumbox').innerHTML = html;
}

/* ─ SUBMIT ─ */
async function submit(){
  if(!photos.length){ alert('กรุณาถ่ายรูปขยะอย่างน้อย 1 รูปค่ะ'); return; }
  el('sbtn').disabled=true;
  el('ld').classList.add('on');

  const ref='WD'+Date.now().toString().slice(-6);
  const items = getSelectedSummary();
  const total = getTotalAmount();
  const totalWt = getTotalWeight();

  const payload={
    ref,
    name:       g('u-name'),
    wasteTypes: getItemizedText(),
    totalWeight: totalWt,
    totalAmount: total,
    items:      items.map(i=>({name:i.name, weight:i.wt, pricePerKg:i.price, subtotal:i.sub})),
    timestamp:  new Date().toLocaleString('th-TH'),
    photos:     photos.map(p=>({name:p.name,type:p.type,data:p.dataUrl.split(',')[1]}))
  };

  try{
    el('ld-txt').textContent='กำลังอัปโหลดรูป...';
    el('ld-sub').textContent=photos.length+' รูป';

    if(GAS_URL && !GAS_URL.includes('YOUR_GOOGLE')){
      await fetch(GAS_URL,{
        method:'POST',
        mode:'no-cors',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify(payload)
      });
    } else {
      await new Promise(r=>setTimeout(r,2000));
    }

    el('ld-txt').textContent='เสร็จแล้วค่ะ!';
    await new Promise(r=>setTimeout(r,500));
    el('ld').classList.remove('on');

    // Accumulate session total
    sessionTotal += total;

    // Success page
    el('refnum').textContent=ref;
    el('done-earn').textContent=sessionTotal.toFixed(2)+' บาท';
    el('done-earn-sub').textContent=sessionTotal>total?'รายการนี้ '+total.toFixed(2)+' บ. · สะสม '+sessionTotal.toFixed(2)+' บ.':'';

    let doneHtml = [
      ['👤 ชื่อผู้ฝาก', payload.name || '-'],
    ].map(([k,v])=>
      `<div class="srow"><span class="sk">${k}</span><span class="sv">${esc(v)}</span></div>`
    ).join('');

    doneHtml += items.map(i=>
      `<div class="srow">
         <span class="sk">${i.emoji} ${i.name}<br><small style="color:var(--txt3);font-weight:400">${i.wt} กก. × ${formatPrice(i.price)} บ./กก.</small></span>
         <span class="sv">${i.sub.toFixed(2)} บาท</span>
       </div>`
    ).join('');

    doneHtml += `<div class="sum-total">
      <span class="sum-total-lbl">📷 รูปที่ส่ง</span>
      <span class="sum-total-val" style="font-size:16px">${photos.length} รูป</span>
    </div>`;

    el('done-sum').innerHTML=doneHtml;
    show('p3'); setFlow(4); scrollTop();
  }catch(e){
    el('ld').classList.remove('on');
    alert('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้งค่ะ');
    el('sbtn').disabled=false;
  }
}

/* ─ RESET ─ */
function reset(){
  const savedName = g('u-name');
  WASTE_TYPES.forEach(w=>{
    const cb=el(w.id);
    if(cb){ cb.checked=false; }
    const det=el('det-'+w.id);
    if(det){ det.classList.remove('show'); }
    const wt=el('wt-'+w.id);
    if(wt){ wt.value=''; }
  });
  el('u-name').value=savedName;
  el('sbtn').disabled=false;
  photos=[]; renderPrev();
  calcPrice();
  show('p1'); setFlow(1); scrollTop();
}

/* ─ UTILS ─ */
function g(id){ return document.getElementById(id).value.trim(); }
function el(id){ return document.getElementById(id); }
function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

/* ─ INIT ─ */
buildGrid();
calcPrice();
</script>
</body>
</html>
