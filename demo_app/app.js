// Inxee HR OS • Notion Workspace Engine

// Dataset Store
const initialNotionStore = {
  theme: "light",
  currentRole: "employee", // 'employee' or 'admin'
  currentPage: "overview",
  isClockedIn: false,
  clockInTime: "09:15 AM",
  clockOutTime: null,
  
  employees: [
    {
      id: "EMP001",
      name: "Deepanshu Garhkoti",
      email: "deepanshuGarhkoti@gmail.com",
      role: "SDE Intern",
      department: "Engineering",
      joinDate: "2024-01-15",
      phone: "+91 98765 43210",
      avatar: "https://images.unsplash.com/photo-1517423738875-5ce310acd3da?auto=format&fit=crop&w=300&q=80",
      salary: { base: 25000, allowance: 5000, deductions: 1500, net: 28500 },
      tags: ["Full-Time", "Core Team"]
    },
    {
      id: "EMP002",
      name: "Rahul Sharma",
      email: "rahul.sharma@inxee.com",
      role: "Frontend Engineer",
      department: "Engineering",
      joinDate: "2023-11-01",
      phone: "+91 98123 45678",
      avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
      salary: { base: 35000, allowance: 7000, deductions: 2000, net: 40000 },
      tags: ["Frontend", "UI/UX"]
    },
    {
      id: "EMP003",
      name: "Priya Patel",
      email: "priya.patel@inxee.com",
      role: "Product Designer",
      department: "Design",
      joinDate: "2024-02-10",
      phone: "+91 99887 76655",
      avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80",
      salary: { base: 30000, allowance: 6000, deductions: 1800, net: 34200 },
      tags: ["Design", "Figma"]
    },
    {
      id: "EMP004",
      name: "Ananya Verma",
      email: "ananya.verma@inxee.com",
      role: "Talent Acquisition",
      department: "Human Resources",
      joinDate: "2024-03-01",
      phone: "+91 98000 11223",
      avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80",
      salary: { base: 32000, allowance: 5000, deductions: 1600, net: 35400 },
      tags: ["HR", "Operations"]
    }
  ],

  attendance: [
    { date: "2026-08-23", employeeId: "EMP001", name: "Deepanshu Garhkoti", checkIn: "09:15 AM", checkOut: "06:30 PM", status: "Present", duration: "9h 15m" },
    { date: "2026-08-22", employeeId: "EMP001", name: "Deepanshu Garhkoti", checkIn: "09:02 AM", checkOut: "06:05 PM", status: "Present", duration: "9h 03m" },
    { date: "2026-08-21", employeeId: "EMP001", name: "Deepanshu Garhkoti", checkIn: "09:45 AM", checkOut: "06:15 PM", status: "Late", duration: "8h 30m" },
    { date: "2026-08-20", employeeId: "EMP001", name: "Deepanshu Garhkoti", checkIn: "09:00 AM", checkOut: "06:00 PM", status: "Present", duration: "9h 00m" },
    { date: "2026-08-23", employeeId: "EMP002", name: "Rahul Sharma", checkIn: "08:55 AM", checkOut: "06:00 PM", status: "Present", duration: "9h 05m" },
    { date: "2026-08-23", employeeId: "EMP003", name: "Priya Patel", checkIn: "09:40 AM", checkOut: "06:10 PM", status: "Late", duration: "8h 30m" }
  ],

  leaveApplications: [
    { id: "LV-101", employeeId: "EMP001", employeeName: "Deepanshu Garhkoti", selectedDate: "2026-08-28", range: "Full Day", title: "Personal Emergency & Errands", application: "Attending family commitment and personal urgent work.", status: "Pending" },
    { id: "LV-100", employeeId: "EMP002", employeeName: "Rahul Sharma", selectedDate: "2026-08-15", range: "Half Day", title: "Medical Checkup", application: "Routine eye doctor checkup in the afternoon.", status: "Approved" },
    { id: "LV-099", employeeId: "EMP003", employeeName: "Priya Patel", selectedDate: "2026-08-10", range: "Full Day", title: "Festival Holiday Leave", application: "Traveling home for family festival gathering.", status: "Approved" },
    { id: "LV-098", employeeId: "EMP004", employeeName: "Ananya Verma", selectedDate: "2026-08-05", range: "Full Day", title: "Personal Leave", application: "Personal day off.", status: "Rejected" }
  ]
};

// Storage Helpers
function getStore() {
  const data = localStorage.getItem("inxee_notion_hr_store");
  if (!data) {
    localStorage.setItem("inxee_notion_hr_store", JSON.stringify(initialNotionStore));
    return initialNotionStore;
  }
  return JSON.parse(data);
}

function saveStore(store) {
  localStorage.setItem("inxee_notion_hr_store", JSON.stringify(store));
}

// App State
let store = getStore();

// Initialization
document.addEventListener("DOMContentLoaded", () => {
  applyTheme(store.theme || "light");
  renderSidebar();
  navigatePage(store.currentPage || "overview");

  // Keyboard shortcut Ctrl+K for search
  document.addEventListener("keydown", (e) => {
    if ((e.ctrlKey || e.metaKey) && e.key === "k") {
      e.preventDefault();
      openSearchModal();
    }
  });
});

// Theme Toggle
function toggleTheme() {
  const newTheme = store.theme === "dark" ? "light" : "dark";
  store.theme = newTheme;
  saveStore(store);
  applyTheme(newTheme);
}

function applyTheme(theme) {
  document.documentElement.setAttribute("data-theme", theme);
  const themeLabel = document.getElementById("themeToggleLabel");
  if (themeLabel) themeLabel.innerText = theme === "dark" ? "Light Mode" : "Dark Mode";
}

// Sidebar Render
function renderSidebar() {
  const isAdmin = store.currentRole === "admin";
  const currentUser = isAdmin 
    ? { name: "Sarah Jenkins", role: "HR Administrator", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80" }
    : store.employees[0];

  document.getElementById("sidebarWsTitle").innerText = "Inxee Systems";
  document.getElementById("sidebarWsSubtitle").innerText = isAdmin ? "Administrator Workspace" : "Employee Workspace";
  document.getElementById("sidebarUserName").innerText = currentUser.name;
  document.getElementById("sidebarUserRole").innerText = currentUser.role || (isAdmin ? "Admin" : "Employee");
  document.getElementById("sidebarUserAvatar").src = currentUser.avatar;
  document.getElementById("topbarRoleLabel").innerText = isAdmin ? "Switch to Employee View" : "Switch to Admin Mode";

  const pages = [
    { id: "overview", name: "Overview & Clock", emoji: "⚡" },
    { id: "attendance", name: "Attendance Database", emoji: "📅" },
    { id: "leaves", name: "Leave Management", emoji: "🌴", badge: store.leaveApplications.filter(l => l.status === "Pending").length },
    { id: "salary", name: "Payroll & Compensation", emoji: "💰" },
    { id: "team", name: "Team Directory", emoji: "👥" },
    { id: "docs", name: "Docs & Policies", emoji: "📑" },
    { id: "profile", name: "My Profile", emoji: "👤" }
  ];

  const navList = document.getElementById("sidebarNavList");
  navList.innerHTML = pages.map(p => `
    <li class="sidebar-item ${store.currentPage === p.id ? 'active' : ''}" onclick="navigatePage('${p.id}')">
      <span class="item-emoji">${p.emoji}</span>
      <span>${p.name}</span>
      ${p.badge ? `<span class="item-badge">${p.badge}</span>` : ''}
    </li>
  `).join('');
}

// Navigation Handler
function navigatePage(pageId) {
  store.currentPage = pageId;
  saveStore(store);
  renderSidebar();

  const canvas = document.getElementById("notionCanvas");
  const topbarTitle = document.getElementById("topbarPageTitle");

  switch(pageId) {
    case "overview":
      topbarTitle.innerText = "Overview & Clock";
      renderOverviewPage(canvas);
      break;
    case "attendance":
      topbarTitle.innerText = "Attendance Database";
      renderAttendancePage(canvas);
      break;
    case "leaves":
      topbarTitle.innerText = "Leave Management";
      renderLeavesPage(canvas);
      break;
    case "salary":
      topbarTitle.innerText = "Payroll & Compensation";
      renderSalaryPage(canvas);
      break;
    case "team":
      topbarTitle.innerText = "Team Directory";
      renderTeamPage(canvas);
      break;
    case "docs":
      topbarTitle.innerText = "Docs & Policies";
      renderDocsPage(canvas);
      break;
    case "profile":
      topbarTitle.innerText = "My Profile";
      renderProfilePage(canvas);
      break;
  }
}

function switchRoleToggle() {
  store.currentRole = store.currentRole === "admin" ? "employee" : "admin";
  saveStore(store);
  renderSidebar();
  navigatePage(store.currentPage);
}

function toggleSidebar() {
  const sidebar = document.getElementById("notionSidebar");
  const expandBtn = document.getElementById("sidebarExpandBtn");
  sidebar.classList.toggle("collapsed");
  expandBtn.style.display = sidebar.classList.contains("collapsed") ? "inline-flex" : "none";
}

// -------------------------------------------------------------
// 1. OVERVIEW & PUNCH CLOCK PAGE (NOTION STYLE)
// -------------------------------------------------------------
function renderOverviewPage(container) {
  const now = new Date();
  const todayStr = now.toLocaleDateString(undefined, { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
  const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

  container.innerHTML = `
    <div class="page-icon">⚡</div>
    <h1 class="page-title">Workforce & Attendance Operating System</h1>

    <!-- Notion Properties Block -->
    <div class="properties-grid">
      <div class="prop-label"><i class="fa-regular fa-building"></i> Workspace</div>
      <div class="prop-value"><strong>Inxee Engineering HQ</strong></div>

      <div class="prop-label"><i class="fa-regular fa-user"></i> Active User</div>
      <div class="prop-value">
        <span class="tag tag-blue">${store.currentRole === 'admin' ? 'Sarah Jenkins (Admin)' : 'Deepanshu Garhkoti (SDE Intern)'}</span>
      </div>

      <div class="prop-label"><i class="fa-regular fa-calendar"></i> Today's Date</div>
      <div class="prop-value">${todayStr}</div>

      <div class="prop-label"><i class="fa-solid fa-signal"></i> System Status</div>
      <div class="prop-value"><span class="tag tag-green">● Online & Operational</span></div>
    </div>

    <!-- Live Punch Clock Banner -->
    <div class="clock-banner">
      <div>
        <div style="font-size: 12px; color: var(--notion-text-muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Live Punch Clock</div>
        <div class="clock-live-time">${timeStr}</div>
        <div style="font-size: 13px; color: var(--notion-text-subtle); margin-top: 4px;">
          Status: <strong style="color: ${store.isClockedIn ? 'var(--notion-green)' : 'var(--notion-text-muted)'};">${store.isClockedIn ? 'Checked In (09:15 AM)' : 'Not Punched In'}</strong>
        </div>
      </div>
      <div>
        <button class="notion-btn" style="padding: 10px 18px; font-size: 14px; background: ${store.isClockedIn ? 'var(--notion-red)' : 'var(--notion-blue)'};" onclick="toggleClockInOut()">
          <i class="fa-solid ${store.isClockedIn ? 'fa-stopwatch' : 'fa-fingerprint'}"></i>
          <span>${store.isClockedIn ? 'PUNCH OUT' : 'PUNCH IN NOW'}</span>
        </button>
      </div>
    </div>

    <!-- Notion Callout Block -->
    <div class="notion-callout-box">
      <div class="callout-icon">💡</div>
      <div class="callout-content">
        <div class="callout-title">Quick Action Navigation</div>
        <div class="callout-desc">
          Use the left sidebar or the buttons below to log attendance, review leave requests, or audit payroll disbursements.
        </div>
        <div style="margin-top: 10px; display: flex; gap: 8px;">
          <button class="notion-btn-outline" onclick="navigatePage('leaves')"><i class="fa-solid fa-calendar-plus"></i> Apply Leave</button>
          <button class="notion-btn-outline" onclick="navigatePage('salary')"><i class="fa-solid fa-wallet"></i> View Payslip</button>
          <button class="notion-btn-outline" onclick="navigatePage('team')"><i class="fa-solid fa-users"></i> Team Directory</button>
        </div>
      </div>
    </div>

    <!-- Recent Attendance Database View -->
    <div class="db-header">
      <div class="db-title"><i class="fa-regular fa-calendar-check"></i> Recent Attendance Records</div>
      <button class="notion-btn-outline" onclick="navigatePage('attendance')">View All Database Rows →</button>
    </div>

    <div class="notion-table-wrap">
      <table class="notion-table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Employee</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Duration</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          ${store.attendance.slice(0, 4).map(r => `
            <tr>
              <td><span style="font-family: 'JetBrains Mono', monospace;">${r.date}</span></td>
              <td><strong>${r.name}</strong></td>
              <td>${r.checkIn || '--'}</td>
              <td>${r.checkOut || '--'}</td>
              <td>${r.duration || '--'}</td>
              <td><span class="tag ${r.status === 'Present' ? 'tag-green' : 'tag-yellow'}">${r.status}</span></td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

function toggleClockInOut() {
  store.isClockedIn = !store.isClockedIn;
  const now = new Date();
  const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  const dateStr = now.toISOString().split('T')[0];

  if (store.isClockedIn) {
    store.attendance.unshift({
      date: dateStr,
      employeeId: "EMP001",
      name: "Deepanshu Garhkoti",
      checkIn: timeStr,
      checkOut: null,
      status: "Present",
      duration: "In Progress"
    });
  } else {
    const todayLog = store.attendance.find(a => a.employeeId === "EMP001" && a.date === dateStr);
    if (todayLog) {
      todayLog.checkOut = timeStr;
      todayLog.duration = "8h 45m";
    }
  }
  saveStore(store);
  renderOverviewPage(document.getElementById("notionCanvas"));
}

// -------------------------------------------------------------
// 2. ATTENDANCE DATABASE PAGE (NOTION TABLE VIEW)
// -------------------------------------------------------------
function renderAttendancePage(container) {
  container.innerHTML = `
    <div class="page-icon">📅</div>
    <h1 class="page-title">Attendance Database</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-solid fa-database"></i> Database</div>
      <div class="prop-value">Workforce Time & Attendance Ledger</div>
      <div class="prop-label"><i class="fa-solid fa-filter"></i> Total Logs</div>
      <div class="prop-value"><strong>${store.attendance.length} Records</strong></div>
    </div>

    <!-- Database Toolbar & Tabs -->
    <div class="db-views">
      <button class="db-tab active"><i class="fa-solid fa-table-list"></i> All Records (${store.attendance.length})</button>
      <button class="db-tab" onclick="alert('Filtering to Present records')"><i class="fa-solid fa-circle-check"></i> Present</button>
      <button class="db-tab" onclick="alert('Filtering to Late records')"><i class="fa-solid fa-clock"></i> Exceptions</button>
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
      <div style="display: flex; gap: 8px;">
        <input type="text" class="notion-input" placeholder="Search by name or date..." style="width: 240px;" oninput="filterAttendanceTable(this.value)">
      </div>
      <button class="notion-btn" onclick="openAddAttendanceModal()"><i class="fa-solid fa-plus"></i> Add Log Row</button>
    </div>

    <!-- Notion Data Table -->
    <div class="notion-table-wrap">
      <table class="notion-table" id="attendanceTable">
        <thead>
          <tr>
            <th>Date</th>
            <th>Employee</th>
            <th>Department</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody id="attendanceTbody">
          ${store.attendance.map(r => `
            <tr>
              <td><span style="font-family: 'JetBrains Mono', monospace;">${r.date}</span></td>
              <td><strong>${r.name}</strong></td>
              <td><span class="tag tag-gray">Engineering</span></td>
              <td>${r.checkIn || '--'}</td>
              <td>${r.checkOut || '--'}</td>
              <td><span class="tag ${r.status === 'Present' ? 'tag-green' : 'tag-yellow'}">${r.status}</span></td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

function filterAttendanceTable(query) {
  const rows = document.querySelectorAll("#attendanceTbody tr");
  rows.forEach(r => {
    const text = r.innerText.toLowerCase();
    r.style.display = text.includes(query.toLowerCase()) ? "" : "none";
  });
}

// -------------------------------------------------------------
// 3. LEAVE MANAGEMENT PAGE (NOTION KANBAN & TABLE)
// -------------------------------------------------------------
function renderLeavesPage(container) {
  const pending = store.leaveApplications.filter(l => l.status === "Pending");
  const approved = store.leaveApplications.filter(l => l.status === "Approved");
  const rejected = store.leaveApplications.filter(l => l.status === "Rejected");

  container.innerHTML = `
    <div class="page-icon">🌴</div>
    <h1 class="page-title">Leave Applications & Approval</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-regular fa-clock"></i> Pending Review</div>
      <div class="prop-value"><span class="tag tag-yellow">${pending.length} Pending Approval</span></div>
      <div class="prop-label"><i class="fa-regular fa-circle-check"></i> Approved Total</div>
      <div class="prop-value"><span class="tag tag-green">${approved.length} Approved</span></div>
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
      <div class="db-views" style="margin-bottom: 0;">
        <button class="db-tab active"><i class="fa-solid fa-border-all"></i> Kanban Board View</button>
      </div>
      <button class="notion-btn" onclick="openApplyLeaveModal()"><i class="fa-solid fa-plus"></i> Apply for Leave</button>
    </div>

    <!-- Notion Kanban Board -->
    <div class="kanban-grid">
      
      <!-- Pending Column -->
      <div class="kanban-col">
        <div class="kanban-col-header">
          <span><span class="tag tag-yellow">⏳ Pending</span></span>
          <span style="font-size: 12px; color: var(--notion-text-subtle);">${pending.length}</span>
        </div>
        ${pending.map((l, idx) => `
          <div class="kanban-card">
            <div style="font-weight: 600; font-size: 13.5px; margin-bottom: 4px;">${l.title}</div>
            <div style="font-size: 12px; color: var(--notion-text-muted); margin-bottom: 8px;">${l.application}</div>
            <div style="font-size: 11.5px; color: var(--notion-text-subtle); display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--notion-border-subtle); padding-top: 6px;">
              <span>👤 ${l.employeeName}</span>
              <span class="tag tag-gray">${l.selectedDate}</span>
            </div>
            ${store.currentRole === 'admin' ? `
              <div style="display: flex; gap: 6px; margin-top: 10px;">
                <button class="notion-btn" style="flex: 1; padding: 4px 8px; font-size: 11px; background: var(--notion-green);" onclick="updateLeaveStatus('${l.id}', 'Approved')">Approve</button>
                <button class="notion-btn-outline" style="flex: 1; padding: 4px 8px; font-size: 11px; color: var(--notion-red);" onclick="updateLeaveStatus('${l.id}', 'Rejected')">Reject</button>
              </div>
            ` : ''}
          </div>
        `).join('')}
      </div>

      <!-- Approved Column -->
      <div class="kanban-col">
        <div class="kanban-col-header">
          <span><span class="tag tag-green">✅ Approved</span></span>
          <span style="font-size: 12px; color: var(--notion-text-subtle);">${approved.length}</span>
        </div>
        ${approved.map(l => `
          <div class="kanban-card">
            <div style="font-weight: 600; font-size: 13.5px; margin-bottom: 4px;">${l.title}</div>
            <div style="font-size: 12px; color: var(--notion-text-muted); margin-bottom: 8px;">${l.application}</div>
            <div style="font-size: 11.5px; color: var(--notion-text-subtle); display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--notion-border-subtle); padding-top: 6px;">
              <span>👤 ${l.employeeName}</span>
              <span class="tag tag-green">${l.selectedDate}</span>
            </div>
          </div>
        `).join('')}
      </div>

      <!-- Rejected Column -->
      <div class="kanban-col">
        <div class="kanban-col-header">
          <span><span class="tag tag-red">❌ Rejected</span></span>
          <span style="font-size: 12px; color: var(--notion-text-subtle);">${rejected.length}</span>
        </div>
        ${rejected.map(l => `
          <div class="kanban-card">
            <div style="font-weight: 600; font-size: 13.5px; margin-bottom: 4px;">${l.title}</div>
            <div style="font-size: 12px; color: var(--notion-text-muted); margin-bottom: 8px;">${l.application}</div>
            <div style="font-size: 11.5px; color: var(--notion-text-subtle); display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--notion-border-subtle); padding-top: 6px;">
              <span>👤 ${l.employeeName}</span>
              <span class="tag tag-red">${l.selectedDate}</span>
            </div>
          </div>
        `).join('')}
      </div>

    </div>
  `;
}

function updateLeaveStatus(id, newStatus) {
  const item = store.leaveApplications.find(l => l.id === id);
  if (item) {
    item.status = newStatus;
    saveStore(store);
    renderLeavesPage(document.getElementById("notionCanvas"));
    renderSidebar();
  }
}

// -------------------------------------------------------------
// 4. PAYROLL & COMPENSATION PAGE (NOTION FORMAT)
// -------------------------------------------------------------
function renderSalaryPage(container) {
  const emp = store.employees[0];
  const sal = emp.salary;

  container.innerHTML = `
    <div class="page-icon">💰</div>
    <h1 class="page-title">Payroll & Compensation Matrix</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-regular fa-credit-card"></i> Disbursement</div>
      <div class="prop-value"><span class="tag tag-green">Monthly (Auto-Disbursed)</span></div>
      <div class="prop-label"><i class="fa-solid fa-indian-rupee-sign"></i> Current Net Pay</div>
      <div class="prop-value"><strong>₹${sal.net.toLocaleString()} / month</strong></div>
    </div>

    <!-- Payslip Callout Block -->
    <div class="notion-callout-box" style="border-left: 3px solid var(--notion-green);">
      <div class="callout-icon">💵</div>
      <div class="callout-content">
        <div class="callout-title">Digital Payslip Breakdown • August 2026</div>
        <div class="callout-desc">Verified by Inxee Finance & Payroll Engine. Download official slip anytime.</div>
        <div style="margin-top: 14px; display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; font-size: 13px;">
          <div>
            <div style="color: var(--notion-text-subtle); font-size: 11px;">BASIC PAY</div>
            <div style="font-weight: 600; font-size: 16px;">₹${sal.base.toLocaleString()}</div>
          </div>
          <div>
            <div style="color: var(--notion-text-subtle); font-size: 11px;">HRA & ALLOWANCES</div>
            <div style="font-weight: 600; font-size: 16px; color: var(--notion-green);">+ ₹${sal.allowance.toLocaleString()}</div>
          </div>
          <div>
            <div style="color: var(--notion-text-subtle); font-size: 11px;">DEDUCTIONS (PF/TAX)</div>
            <div style="font-weight: 600; font-size: 16px; color: var(--notion-red);">- ₹${sal.deductions.toLocaleString()}</div>
          </div>
          <div>
            <div style="color: var(--notion-text-subtle); font-size: 11px;">NET PAYABLE</div>
            <div style="font-weight: 700; font-size: 18px; color: var(--notion-blue);">₹${sal.net.toLocaleString()}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Company Payroll Database Table -->
    <div class="db-header">
      <div class="db-title"><i class="fa-solid fa-money-check-dollar"></i> Workforce Compensation Ledger</div>
      <button class="notion-btn-outline" onclick="alert('Exporting Payroll Ledger...')"><i class="fa-solid fa-file-excel"></i> Export Matrix</button>
    </div>

    <div class="notion-table-wrap">
      <table class="notion-table">
        <thead>
          <tr>
            <th>Employee</th>
            <th>Role</th>
            <th>Base Salary</th>
            <th>Allowances</th>
            <th>Deductions</th>
            <th>Net Monthly Payout</th>
          </tr>
        </thead>
        <tbody>
          ${store.employees.map(e => `
            <tr>
              <td><strong>${e.name}</strong> <span style="font-size: 11px; color: var(--notion-text-subtle);">(${e.id})</span></td>
              <td><span class="tag tag-blue">${e.role}</span></td>
              <td>₹${e.salary.base.toLocaleString()}</td>
              <td>+ ₹${e.salary.allowance.toLocaleString()}</td>
              <td style="color: var(--notion-red);">- ₹${e.salary.deductions.toLocaleString()}</td>
              <td><strong>₹${e.salary.net.toLocaleString()}</strong></td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

// -------------------------------------------------------------
// 5. TEAM DIRECTORY PAGE (NOTION GALLERY & TABLE)
// -------------------------------------------------------------
function renderTeamPage(container) {
  container.innerHTML = `
    <div class="page-icon">👥</div>
    <h1 class="page-title">Team Directory & Workforce</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-solid fa-users"></i> Headcount</div>
      <div class="prop-value"><strong>${store.employees.length} Active Team Members</strong></div>
      <div class="prop-label"><i class="fa-solid fa-building"></i> Departments</div>
      <div class="prop-value"><span class="tag tag-gray">Engineering</span> <span class="tag tag-gray">Design</span> <span class="tag tag-gray">Human Resources</span></div>
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
      <div class="db-views" style="margin-bottom: 0;">
        <button class="db-tab active"><i class="fa-solid fa-table"></i> Table Directory</button>
      </div>
      <button class="notion-btn" onclick="openAddMemberModal()"><i class="fa-solid fa-user-plus"></i> Add Team Member</button>
    </div>

    <div class="notion-table-wrap">
      <table class="notion-table">
        <thead>
          <tr>
            <th>Member</th>
            <th>Designation</th>
            <th>Department</th>
            <th>Email</th>
            <th>Join Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          ${store.employees.map(e => `
            <tr>
              <td>
                <div style="display: flex; align-items: center; gap: 8px;">
                  <img src="${e.avatar}" style="width: 24px; height: 24px; border-radius: 50%; object-fit: cover;">
                  <strong>${e.name}</strong>
                </div>
              </td>
              <td><span class="tag tag-blue">${e.role}</span></td>
              <td><span class="tag tag-gray">${e.department}</span></td>
              <td><span style="font-family: 'JetBrains Mono', monospace; font-size: 12px;">${e.email}</span></td>
              <td>${e.joinDate}</td>
              <td><span class="tag tag-green">Active</span></td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

// -------------------------------------------------------------
// 6. DOCS & POLICIES PAGE (NOTION WIKI FORMAT)
// -------------------------------------------------------------
function renderDocsPage(container) {
  container.innerHTML = `
    <div class="page-icon">📑</div>
    <h1 class="page-title">Company Policies & HR Wiki</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-solid fa-shield-halved"></i> Governance</div>
      <div class="prop-value">Inxee Employee Handbook v2.4</div>
      <div class="prop-label"><i class="fa-solid fa-clock-rotate-left"></i> Last Revision</div>
      <div class="prop-value">August 2026</div>
    </div>

    <div class="notion-callout-box">
      <div class="callout-icon">📌</div>
      <div class="callout-content">
        <div class="callout-title">Core Operating Guidelines</div>
        <div class="callout-desc">
          Core working hours are 09:00 AM - 06:00 PM IST. Please submit all planned leave applications at least 2 business days in advance.
        </div>
      </div>
    </div>

    <div style="margin-top: 24px;">
      <h3 style="font-size: 16px; margin-bottom: 12px; font-weight: 600;">📜 Standard Operating Procedures</h3>
      
      <div style="border: 1px solid var(--notion-border); border-radius: var(--radius-sm); padding: 14px; margin-bottom: 10px; background: var(--notion-card);">
        <strong>1. Daily Attendance Logging</strong>
        <p style="font-size: 13px; color: var(--notion-text-muted); margin-top: 4px;">
          All team members must punch in via the Inxee OS portal or mobile app upon starting shifts.
        </p>
      </div>

      <div style="border: 1px solid var(--notion-border); border-radius: var(--radius-sm); padding: 14px; margin-bottom: 10px; background: var(--notion-card);">
        <strong>2. Paid Time Off (PTO) & Sick Leaves</strong>
        <p style="font-size: 13px; color: var(--notion-text-muted); margin-top: 4px;">
          Full-time and intern staff receive 18 days of paid annual leaves plus emergency medical allocations.
        </p>
      </div>

      <div style="border: 1px solid var(--notion-border); border-radius: var(--radius-sm); padding: 14px; margin-bottom: 10px; background: var(--notion-card);">
        <strong>3. Salary Disbursements</strong>
        <p style="font-size: 13px; color: var(--notion-text-muted); margin-top: 4px;">
          Monthly payroll is computed on the 28th and disbursed on the final day of each calendar month.
        </p>
      </div>
    </div>
  `;
}

// -------------------------------------------------------------
// 7. PROFILE PAGE (NOTION PERSONAL VIEW)
// -------------------------------------------------------------
function renderProfilePage(container) {
  const emp = store.employees[0];

  container.innerHTML = `
    <div class="page-icon">👤</div>
    <h1 class="page-title">${emp.name}</h1>

    <div class="properties-grid">
      <div class="prop-label"><i class="fa-regular fa-id-badge"></i> Employee ID</div>
      <div class="prop-value"><strong>${emp.id}</strong></div>

      <div class="prop-label"><i class="fa-regular fa-envelope"></i> Work Email</div>
      <div class="prop-value">${emp.email}</div>

      <div class="prop-label"><i class="fa-solid fa-briefcase"></i> Designation</div>
      <div class="prop-value"><span class="tag tag-blue">${emp.role}</span></div>

      <div class="prop-label"><i class="fa-solid fa-phone"></i> Phone</div>
      <div class="prop-value">${emp.phone}</div>

      <div class="prop-label"><i class="fa-solid fa-building"></i> Department</div>
      <div class="prop-value"><span class="tag tag-gray">${emp.department}</span></div>

      <div class="prop-label"><i class="fa-regular fa-calendar"></i> Date of Joining</div>
      <div class="prop-value">${emp.joinDate}</div>
    </div>

    <div class="notion-callout-box">
      <div class="callout-icon">✨</div>
      <div class="callout-content">
        <div class="callout-title">Profile Synchronized</div>
        <div class="callout-desc">Your profile data is synchronized with the Inxee HR database and local offline storage.</div>
      </div>
    </div>
  `;
}

// -------------------------------------------------------------
// MODALS & ACTIONS
// -------------------------------------------------------------
function openApplyLeaveModal() {
  const modal = document.getElementById("modalContainer");
  modal.innerHTML = `
    <div class="notion-modal-overlay" onclick="closeModal(event)">
      <div class="notion-modal" onclick="event.stopPropagation()">
        <h3 style="font-size: 18px; margin-bottom: 16px;">Apply for Leave</h3>
        
        <div style="margin-bottom: 12px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Subject / Reason</label>
          <input type="text" id="mLeaveTitle" class="notion-input" placeholder="e.g. Sick Leave / Vacation">
        </div>

        <div style="margin-bottom: 12px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Target Date</label>
          <input type="date" id="mLeaveDate" class="notion-input" value="${new Date().toISOString().split('T')[0]}">
        </div>

        <div style="margin-bottom: 16px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Details</label>
          <textarea id="mLeaveDetails" class="notion-input" rows="3" placeholder="Explain your leave request..."></textarea>
        </div>

        <div style="display: flex; justify-content: flex-end; gap: 8px;">
          <button class="notion-btn-outline" onclick="closeModal()">Cancel</button>
          <button class="notion-btn" onclick="submitModalLeave()">Submit Leave</button>
        </div>
      </div>
    </div>
  `;
}

function submitModalLeave() {
  const title = document.getElementById("mLeaveTitle").value;
  const date = document.getElementById("mLeaveDate").value;
  const details = document.getElementById("mLeaveDetails").value;

  if (!title) {
    alert("Please provide a title for the leave request.");
    return;
  }

  store.leaveApplications.unshift({
    id: "LV-" + Math.floor(100 + Math.random() * 900),
    employeeId: "EMP001",
    employeeName: "Deepanshu Garhkoti",
    selectedDate: date,
    range: "Full Day",
    title: title,
    application: details || title,
    status: "Pending"
  });

  saveStore(store);
  closeModal();
  navigatePage("leaves");
}

function openAddMemberModal() {
  const modal = document.getElementById("modalContainer");
  modal.innerHTML = `
    <div class="notion-modal-overlay" onclick="closeModal(event)">
      <div class="notion-modal" onclick="event.stopPropagation()">
        <h3 style="font-size: 18px; margin-bottom: 16px;">Add New Team Member</h3>
        
        <div style="margin-bottom: 12px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Full Name</label>
          <input type="text" id="mMemName" class="notion-input" placeholder="e.g. Vikram Joshi">
        </div>

        <div style="margin-bottom: 12px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Designation / Role</label>
          <input type="text" id="mMemRole" class="notion-input" placeholder="e.g. Backend Engineer">
        </div>

        <div style="margin-bottom: 16px;">
          <label style="font-size: 12px; font-weight: 600; color: var(--notion-text-muted); display: block; margin-bottom: 4px;">Department</label>
          <input type="text" id="mMemDept" class="notion-input" placeholder="e.g. Engineering">
        </div>

        <div style="display: flex; justify-content: flex-end; gap: 8px;">
          <button class="notion-btn-outline" onclick="closeModal()">Cancel</button>
          <button class="notion-btn" onclick="submitModalMember()">Add Member</button>
        </div>
      </div>
    </div>
  `;
}

function submitModalMember() {
  const name = document.getElementById("mMemName").value;
  const role = document.getElementById("mMemRole").value;
  const dept = document.getElementById("mMemDept").value;

  if (!name) return;

  store.employees.push({
    id: "EMP00" + (store.employees.length + 1),
    name: name,
    email: name.toLowerCase().replace(/\s+/g, '.') + "@inxee.com",
    role: role || "Software Engineer",
    department: dept || "Engineering",
    joinDate: new Date().toISOString().split('T')[0],
    phone: "+91 98000 11223",
    avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80",
    salary: { base: 30000, allowance: 5000, deductions: 1500, net: 33500 },
    tags: ["Full-Time"]
  });

  saveStore(store);
  closeModal();
  navigatePage("team");
}

function openSearchModal() {
  const modal = document.getElementById("modalContainer");
  modal.innerHTML = `
    <div class="notion-modal-overlay" onclick="closeModal(event)">
      <div class="notion-modal" style="width: 480px; padding: 16px;" onclick="event.stopPropagation()">
        <input type="text" id="quickSearchInput" class="notion-input" placeholder="Search pages, employees, leaves (Ctrl+K)..." autofocus oninput="handleQuickSearch(this.value)">
        <div id="quickSearchResults" style="margin-top: 12px; font-size: 13px; max-height: 240px; overflow-y: auto;">
          <div class="sidebar-item" onclick="navigatePage('overview'); closeModal();">⚡ Overview & Live Clock</div>
          <div class="sidebar-item" onclick="navigatePage('attendance'); closeModal();">📅 Attendance Database</div>
          <div class="sidebar-item" onclick="navigatePage('leaves'); closeModal();">🌴 Leave Management & Approval</div>
          <div class="sidebar-item" onclick="navigatePage('salary'); closeModal();">💰 Payroll & Compensation</div>
          <div class="sidebar-item" onclick="navigatePage('team'); closeModal();">👥 Team Directory</div>
        </div>
      </div>
    </div>
  `;
  setTimeout(() => document.getElementById("quickSearchInput")?.focus(), 50);
}

function handleQuickSearch(query) {
  const container = document.getElementById("quickSearchResults");
  if (!query) {
    container.innerHTML = `
      <div class="sidebar-item" onclick="navigatePage('overview'); closeModal();">⚡ Overview & Live Clock</div>
      <div class="sidebar-item" onclick="navigatePage('attendance'); closeModal();">📅 Attendance Database</div>
      <div class="sidebar-item" onclick="navigatePage('leaves'); closeModal();">🌴 Leave Management & Approval</div>
      <div class="sidebar-item" onclick="navigatePage('salary'); closeModal();">💰 Payroll & Compensation</div>
      <div class="sidebar-item" onclick="navigatePage('team'); closeModal();">👥 Team Directory</div>
    `;
    return;
  }

  const q = query.toLowerCase();
  const matches = store.employees.filter(e => e.name.toLowerCase().includes(q) || e.role.toLowerCase().includes(q));
  
  container.innerHTML = matches.map(m => `
    <div class="sidebar-item" onclick="navigatePage('team'); closeModal();">
      <span class="item-emoji">👤</span>
      <span>${m.name} (${m.role})</span>
    </div>
  `).join('') || `<div style="padding: 10px; color: var(--notion-text-subtle);">No matching items found</div>`;
}

function closeModal() {
  document.getElementById("modalContainer").innerHTML = "";
}
