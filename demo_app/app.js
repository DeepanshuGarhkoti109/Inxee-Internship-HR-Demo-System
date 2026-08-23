// Inxee HR Demo System Application Logic with Local Dummy Dataset

// Default Dummy Dataset
const initialDataset = {
  employees: [
    {
      id: "EMP001",
      name: "Deepanshu Garhkoti",
      email: "deepanshuGarhkoti@gmail.com",
      role: "Software Development Engineer Intern",
      department: "Engineering",
      joinDate: "2024-01-15",
      phone: "+91 98765 43210",
      avatar: "https://images.unsplash.com/photo-1517423738875-5ce310acd3da?auto=format&fit=crop&w=300&q=80",
      salary: { base: 25000, allowance: 5000, deductions: 1500, net: 28500 }
    },
    {
      id: "EMP002",
      name: "Rahul Sharma",
      email: "rahul.sharma@inxee.com",
      role: "Frontend Developer",
      department: "Engineering",
      joinDate: "2023-11-01",
      phone: "+91 98123 45678",
      avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
      salary: { base: 35000, allowance: 7000, deductions: 2000, net: 40000 }
    },
    {
      id: "EMP003",
      name: "Priya Patel",
      email: "priya.patel@inxee.com",
      role: "UI/UX Designer",
      department: "Design",
      joinDate: "2024-02-10",
      phone: "+91 99887 76655",
      avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80",
      salary: { base: 30000, allowance: 6000, deductions: 1800, net: 34200 }
    }
  ],
  attendance: [
    { date: "2026-08-23", employeeId: "EMP001", checkIn: "09:15 AM", checkOut: "06:30 PM", status: "Present" },
    { date: "2026-08-22", employeeId: "EMP001", checkIn: "09:02 AM", checkOut: "06:05 PM", status: "Present" },
    { date: "2026-08-21", employeeId: "EMP001", checkIn: "09:45 AM", checkOut: "06:15 PM", status: "Late" },
    { date: "2026-08-20", employeeId: "EMP001", checkIn: "09:00 AM", checkOut: "06:00 PM", status: "Present" },
    { date: "2026-08-23", employeeId: "EMP002", checkIn: "08:55 AM", checkOut: "06:00 PM", status: "Present" }
  ],
  leaveApplications: [
    { id: "LV-101", employeeId: "EMP001", employeeName: "Deepanshu Garhkoti", selectedDate: "2026-08-28", range: "Full Day", application: "Family Emergency & Personal Work", status: "Pending" },
    { id: "LV-100", employeeId: "EMP002", employeeName: "Rahul Sharma", selectedDate: "2026-08-15", range: "Half Day", application: "Doctor Appointment", status: "Approved" },
    { id: "LV-099", employeeId: "EMP003", employeeName: "Priya Patel", selectedDate: "2026-08-10", range: "Full Day", application: "Sick Leave", status: "Approved" }
  ]
};

// Data Store Setup
function getStore() {
  const store = localStorage.getItem("inxee_hr_store");
  if (!store) {
    localStorage.setItem("inxee_hr_store", JSON.stringify(initialDataset));
    return initialDataset;
  }
  return JSON.parse(store);
}

function saveStore(data) {
  localStorage.setItem("inxee_hr_store", JSON.stringify(data));
}

// App State
let currentUser = null;
let currentRole = "employee"; // 'employee' or 'admin'
let activeScreen = "home";
let activeTab = "home";
let isClockedIn = false;

// DOM Elements
const appContent = document.getElementById("appContent");
const drawerOverlay = document.getElementById("drawerOverlay");
const appDrawer = document.getElementById("appDrawer");
const appTitle = document.getElementById("appTitle");
const appTabs = document.getElementById("appTabs");

// Initialization
document.addEventListener("DOMContentLoaded", () => {
  renderLoginScreen();
});

// Render Login Screen
function renderLoginScreen(role = "employee") {
  currentRole = role;
  appTitle.innerText = role === "admin" ? "A D M I N  L O G I N" : "E M P L O Y E E  L O G I N";
  appTabs.style.display = "none";
  
  appContent.innerHTML = `
    <div class="login-screen">
      <div class="login-logo">
        <i class="fa-solid fa-building-user"></i>
      </div>
      <h3 style="margin-bottom: 20px; font-weight: 600;">Inxee HR System</h3>
      
      <div class="form-group">
        <label>Email Address</label>
        <input type="email" id="loginEmail" class="form-input" value="${role === 'admin' ? 'admin@inxee.com' : 'deepanshuGarhkoti@gmail.com'}">
      </div>
      
      <div class="form-group">
        <label>Password</label>
        <input type="password" id="loginPassword" class="form-input" value="password123">
      </div>
      
      <div style="text-align: right; margin-bottom: 20px;">
        <a href="#" onclick="renderOtpScreen(); return false;" style="font-size: 13px; color: #3b82f6; text-decoration: none;">Forgot / Login with OTP?</a>
      </div>
      
      <button class="btn-primary" onclick="handleLogin('${role}')">LOGIN</button>
      
      <div style="margin: 30px 0; position: relative; text-align: center;">
        <hr style="border: 0; border-top: 1px solid #e2e8f0;">
        <span style="position: absolute; top: -10px; left: 50%; transform: translateX(-50%); background: #f8fafc; padding: 0 10px; font-size: 12px; color: #64748b;">OR LOGIN AS</span>
      </div>
      
      <button class="btn-outline" style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 8px;" onclick="renderLoginScreen('${role === 'employee' ? 'admin' : 'employee'}')">
        <i class="fa-solid ${role === 'employee' ? 'fa-user-shield' : 'fa-user'}"></i> Switch to ${role === 'employee' ? 'Admin Login' : 'Employee Login'}
      </button>
    </div>
  `;
}

function handleLogin(role) {
  const store = getStore();
  if (role === "admin") {
    currentUser = {
      id: "ADMIN001",
      name: "Admin User",
      email: "admin@inxee.com",
      role: "System Administrator",
      avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80"
    };
  } else {
    currentUser = store.employees[0];
  }
  
  renderMainApp();
}

function renderOtpScreen() {
  appContent.innerHTML = `
    <div class="login-screen">
      <div class="login-logo"><i class="fa-solid fa-key"></i></div>
      <h3>OTP Authentication</h3>
      <p style="font-size: 13px; color: #64748b; margin-bottom: 20px;">Enter your phone / email to receive high security OTP</p>
      
      <div class="form-group">
        <label>Email or Phone</label>
        <input type="text" class="form-input" value="+91 98765 43210">
      </div>
      
      <div class="form-group">
        <label>Enter 4-Digit OTP</label>
        <input type="text" class="form-input" placeholder="● ● ● ●" value="1234" style="letter-spacing: 8px; text-align: center; font-size: 18px;">
      </div>
      
      <button class="btn-primary" onclick="handleLogin('employee')">VERIFY & CONTINUE</button>
      <button class="btn-outline" style="width: 100%; margin-top: 12px;" onclick="renderLoginScreen('employee')">Back to Login</button>
    </div>
  `;
}

// Render Main App Structure
function renderMainApp() {
  appTitle.innerText = currentRole === "admin" ? "A D M I N   P A N E L" : "E M P L O Y E E   P A N E L";
  appTabs.style.display = "flex";
  
  // Setup Drawer Menu Items
  updateDrawerMenu();
  switchTab('home');
}

function updateDrawerMenu() {
  const drawerName = document.getElementById("drawerName");
  const drawerEmail = document.getElementById("drawerEmail");
  const drawerAvatar = document.getElementById("drawerAvatar");
  const drawerMenuList = document.getElementById("drawerMenuList");
  
  drawerName.innerText = currentUser.name;
  drawerEmail.innerText = currentUser.email;
  drawerAvatar.src = currentUser.avatar;
  
  if (currentRole === "admin") {
    drawerMenuList.innerHTML = `
      <li class="drawer-item active" onclick="switchNavScreen('home')"><i class="fa-solid fa-house"></i> Home</li>
      <li class="drawer-item" onclick="switchNavScreen('salary_admin')"><i class="fa-solid fa-money-bill-wave"></i> Salary Details</li>
      <li class="drawer-item" onclick="switchNavScreen('leave_admin')"><i class="fa-solid fa-calendar-check"></i> Leave Requests</li>
      <li class="drawer-item" onclick="switchNavScreen('checkin_admin')"><i class="fa-solid fa-clipboard-user"></i> Check-in Details</li>
      <li class="drawer-item" onclick="switchNavScreen('employees_admin')"><i class="fa-solid fa-users"></i> Employee Details</li>
      <li class="drawer-item" onclick="switchNavScreen('report')"><i class="fa-solid fa-flag"></i> Reports</li>
      <li class="drawer-item" onclick="logout()"><i class="fa-solid fa-right-from-bracket"></i> Logout</li>
    `;
  } else {
    drawerMenuList.innerHTML = `
      <li class="drawer-item active" onclick="switchNavScreen('home')"><i class="fa-solid fa-house"></i> Home</li>
      <li class="drawer-item" onclick="switchNavScreen('apply_leave')"><i class="fa-solid fa-calendar-plus"></i> Apply Leave</li>
      <li class="drawer-item" onclick="switchNavScreen('salary_emp')"><i class="fa-solid fa-file-invoice-dollar"></i> Salary Details</li>
      <li class="drawer-item" onclick="switchNavScreen('profile')"><i class="fa-solid fa-user"></i> Profile</li>
      <li class="drawer-item" onclick="switchNavScreen('report')"><i class="fa-solid fa-circle-question"></i> Help & Support</li>
      <li class="drawer-item" onclick="logout()"><i class="fa-solid fa-right-from-bracket"></i> Logout</li>
    `;
  }
}

function toggleDrawer() {
  drawerOverlay.classList.toggle("active");
  appDrawer.classList.toggle("open");
}

function switchTab(tab) {
  activeTab = tab;
  document.getElementById("tabHome").classList.toggle("active", tab === "home");
  document.getElementById("tabAttendance").classList.toggle("active", tab === "attendance");
  
  if (tab === "home") {
    renderHomeScreen();
  } else {
    renderAttendanceScreen();
  }
}

function switchNavScreen(screen) {
  toggleDrawer();
  activeScreen = screen;
  
  switch(screen) {
    case "home":
      switchTab("home");
      break;
    case "apply_leave":
      renderApplyLeaveScreen();
      break;
    case "salary_emp":
      renderEmployeeSalaryScreen();
      break;
    case "salary_admin":
      renderAdminSalaryScreen();
      break;
    case "leave_admin":
      renderAdminLeaveScreen();
      break;
    case "checkin_admin":
      renderCheckInDetailsScreen();
      break;
    case "employees_admin":
      renderEmployeesAdminScreen();
      break;
    case "profile":
      renderProfileScreen();
      break;
    case "report":
      renderReportScreen();
      break;
  }
}

// ----------------- SCREENS ----------------- //

function renderHomeScreen() {
  const store = getStore();
  const today = new Date().toISOString().split('T')[0];
  const userTodayAttendance = store.attendance.find(a => a.employeeId === currentUser.id && a.date === today);
  
  appContent.innerHTML = `
    <div class="card" style="background: linear-gradient(135deg, #1e293b, #0f172a); color: white;">
      <div style="display: flex; align-items: center; gap: 12px;">
        <img src="${currentUser.avatar}" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">
        <div>
          <h3 style="font-size: 16px; font-weight: 600;">Welcome back, ${currentUser.name.split(' ')[0]}!</h3>
          <p style="font-size: 12px; color: #94a3b8;">${currentUser.role || 'Employee'}</p>
        </div>
      </div>
    </div>
    
    <div class="card clock-widget">
      <p style="font-size: 13px; color: var(--text-muted); font-weight: 500;">TODAY'S ATTENDANCE</p>
      <h2 style="font-size: 26px; font-weight: 700; margin: 6px 0;">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</h2>
      <p style="font-size: 12px; color: #64748b;">${new Date().toLocaleDateString(undefined, {weekday: 'long', month: 'short', day: 'numeric'})}</p>
      
      <button class="clock-btn ${isClockedIn ? 'clocked-in' : ''}" onclick="toggleClockIn()">
        <i class="fa-solid ${isClockedIn ? 'fa-stopwatch' : 'fa-fingerprint'}" style="font-size: 28px;"></i>
        <span>${isClockedIn ? 'PUNCH OUT' : 'PUNCH IN'}</span>
      </button>
      
      <div style="display: flex; justify-content: space-around; margin-top: 12px; font-size: 13px;">
        <div>
          <span style="color: var(--text-muted); display: block; font-size: 11px;">PUNCH IN</span>
          <strong>${userTodayAttendance ? userTodayAttendance.checkIn : (isClockedIn ? '09:15 AM' : '--:--')}</strong>
        </div>
        <div>
          <span style="color: var(--text-muted); display: block; font-size: 11px;">PUNCH OUT</span>
          <strong>${userTodayAttendance && userTodayAttendance.checkOut ? userTodayAttendance.checkOut : '--:--'}</strong>
        </div>
      </div>
    </div>
    
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-bolt" style="color: #f59e0b;"></i> Quick Services</div>
      <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; text-align: center; font-size: 12px;">
        <div style="padding: 12px; background: #f1f5f9; border-radius: 8px; cursor: pointer;" onclick="switchNavScreen('apply_leave')">
          <i class="fa-solid fa-calendar-plus" style="font-size: 20px; color: #3b82f6; display: block; margin-bottom: 6px;"></i>
          Apply Leave
        </div>
        <div style="padding: 12px; background: #f1f5f9; border-radius: 8px; cursor: pointer;" onclick="switchNavScreen('salary_emp')">
          <i class="fa-solid fa-wallet" style="font-size: 20px; color: #10b981; display: block; margin-bottom: 6px;"></i>
          Payslip
        </div>
        <div style="padding: 12px; background: #f1f5f9; border-radius: 8px; cursor: pointer;" onclick="switchNavScreen('profile')">
          <i class="fa-solid fa-id-card" style="font-size: 20px; color: #8b5cf6; display: block; margin-bottom: 6px;"></i>
          Profile
        </div>
      </div>
    </div>
  `;
}

function toggleClockIn() {
  isClockedIn = !isClockedIn;
  const store = getStore();
  const today = new Date().toISOString().split('T')[0];
  
  if (isClockedIn) {
    store.attendance.unshift({
      date: today,
      employeeId: currentUser.id,
      checkIn: new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'}),
      checkOut: null,
      status: "Present"
    });
  } else {
    const item = store.attendance.find(a => a.employeeId === currentUser.id && a.date === today);
    if (item) {
      item.checkOut = new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    }
  }
  saveStore(store);
  renderHomeScreen();
}

function renderAttendanceScreen() {
  const store = getStore();
  const records = store.attendance.filter(a => currentRole === 'admin' || a.employeeId === currentUser.id);
  
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-calendar-days"></i> Attendance History</div>
      <table class="data-table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          ${records.map(r => `
            <tr>
              <td>${r.date}</td>
              <td>${r.checkIn || '--'}</td>
              <td>${r.checkOut || '--'}</td>
              <td><span class="badge ${r.status === 'Present' ? 'badge-success' : 'badge-warning'}">${r.status}</span></td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

function renderApplyLeaveScreen() {
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-paper-plane"></i> Apply for Leave</div>
      
      <div class="form-group">
        <label>Selected Date</label>
        <input type="date" id="leaveDate" class="form-input" value="${new Date().toISOString().split('T')[0]}">
      </div>
      
      <div class="form-group">
        <label>Duration / Range</label>
        <select id="leaveRange" class="form-input">
          <option value="Full Day">Full Day</option>
          <option value="First Half">First Half</option>
          <option value="Second Half">Second Half</option>
        </select>
      </div>
      
      <div class="form-group">
        <label>Application / Reason</label>
        <textarea id="leaveReason" class="form-input" rows="3" placeholder="Enter reason for leave..."></textarea>
      </div>
      
      <button class="btn-primary" onclick="submitLeaveApplication()">SUBMIT LEAVE</button>
    </div>
    
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-clock-rotate-left"></i> My Leave Applications</div>
      <div id="myLeaveList"></div>
    </div>
  `;
  renderMyLeaves();
}

function submitLeaveApplication() {
  const date = document.getElementById("leaveDate").value;
  const range = document.getElementById("leaveRange").value;
  const reason = document.getElementById("leaveReason").value;
  
  if (!reason) {
    alert("Please provide a reason for the leave application.");
    return;
  }
  
  const store = getStore();
  store.leaveApplications.unshift({
    id: "LV-" + Math.floor(100 + Math.random() * 900),
    employeeId: currentUser.id,
    employeeName: currentUser.name,
    selectedDate: date,
    range: range,
    application: reason,
    status: "Pending"
  });
  saveStore(store);
  renderApplyLeaveScreen();
}

function renderMyLeaves() {
  const store = getStore();
  const leaves = store.leaveApplications.filter(l => l.employeeId === currentUser.id);
  const container = document.getElementById("myLeaveList");
  
  if (leaves.length === 0) {
    container.innerHTML = `<p style="font-size: 13px; color: var(--text-muted);">No leave applications found.</p>`;
    return;
  }
  
  container.innerHTML = leaves.map(l => `
    <div style="padding: 10px; border-bottom: 1px solid var(--border); font-size: 13px;">
      <div style="display: flex; justify-content: space-between; font-weight: 600;">
        <span>${l.selectedDate} (${l.range})</span>
        <span class="badge ${l.status === 'Approved' ? 'badge-success' : (l.status === 'Rejected' ? 'badge-danger' : 'badge-warning')}">${l.status}</span>
      </div>
      <p style="color: var(--text-muted); margin-top: 4px;">${l.application}</p>
    </div>
  `).join('');
}

function renderEmployeeSalaryScreen() {
  const sal = currentUser.salary || { base: 25000, allowance: 5000, deductions: 1500, net: 28500 };
  
  appContent.innerHTML = `
    <div class="card" style="background: linear-gradient(135deg, #10b981, #047857); color: white;">
      <p style="font-size: 12px; opacity: 0.9;">NET PAYABLE SALARY (MONTHLY)</p>
      <h2 style="font-size: 32px; font-weight: 700; margin: 8px 0;">₹${sal.net.toLocaleString()}</h2>
      <p style="font-size: 12px; opacity: 0.9;"><i class="fa-solid fa-circle-check"></i> Status: Disbursed</p>
    </div>
    
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-list-check"></i> Salary Breakdown</div>
      <table class="data-table">
        <tr><td>Basic Salary</td><td style="text-align: right; font-weight: 600;">₹${sal.base.toLocaleString()}</td></tr>
        <tr><td>Allowances & HRA</td><td style="text-align: right; font-weight: 600;">+ ₹${sal.allowance.toLocaleString()}</td></tr>
        <tr><td>Deductions (PF/TDS)</td><td style="text-align: right; font-weight: 600; color: #ef4444;">- ₹${sal.deductions.toLocaleString()}</td></tr>
        <tr style="border-top: 2px solid var(--border);">
          <td style="font-weight: 700;">Net Salary</td>
          <td style="text-align: right; font-weight: 700; color: #10b981;">₹${sal.net.toLocaleString()}</td>
        </tr>
      </table>
    </div>
  `;
}

function renderAdminLeaveScreen() {
  const store = getStore();
  
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-envelope-open-text"></i> Leave Requests Management</div>
      ${store.leaveApplications.length === 0 ? '<p>No pending leave requests.</p>' : ''}
      ${store.leaveApplications.map((l, index) => `
        <div style="padding: 12px; background: #f8fafc; border: 1px solid var(--border); border-radius: 8px; margin-bottom: 12px; font-size: 13px;">
          <div style="display: flex; justify-content: space-between; font-weight: 600;">
            <span>${l.employeeName}</span>
            <span class="badge ${l.status === 'Approved' ? 'badge-success' : (l.status === 'Rejected' ? 'badge-danger' : 'badge-warning')}">${l.status}</span>
          </div>
          <p style="margin: 4px 0;"><strong>Date:</strong> ${l.selectedDate} (${l.range})</p>
          <p style="color: var(--text-muted); margin-bottom: 8px;">"${l.application}"</p>
          
          ${l.status === 'Pending' ? `
            <div style="display: flex; gap: 8px; margin-top: 8px;">
              <button onclick="updateLeaveStatus(${index}, 'Approved')" style="flex: 1; padding: 6px; background: #10b981; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 600;">Approve</button>
              <button onclick="updateLeaveStatus(${index}, 'Rejected')" style="flex: 1; padding: 6px; background: #ef4444; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 600;">Reject</button>
            </div>
          ` : ''}
        </div>
      `).join('')}
    </div>
  `;
}

function updateLeaveStatus(index, status) {
  const store = getStore();
  store.leaveApplications[index].status = status;
  saveStore(store);
  renderAdminLeaveScreen();
}

function renderEmployeesAdminScreen() {
  const store = getStore();
  
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title" style="justify-content: space-between;">
        <span><i class="fa-solid fa-users"></i> Employee Directory</span>
        <button onclick="addNewEmployeePrompt()" style="padding: 6px 10px; background: #000; color: white; border: none; border-radius: 6px; font-size: 11px; cursor: pointer;">+ Add Employee</button>
      </div>
      <table class="data-table">
        <thead>
          <tr>
            <th>Employee</th>
            <th>Department</th>
            <th>Role</th>
          </tr>
        </thead>
        <tbody>
          ${store.employees.map(e => `
            <tr>
              <td>
                <div style="display: flex; align-items: center; gap: 8px;">
                  <img src="${e.avatar}" style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover;">
                  <div>
                    <strong>${e.name}</strong><br>
                    <span style="font-size: 11px; color: var(--text-muted);">${e.id}</span>
                  </div>
                </div>
              </td>
              <td>${e.department}</td>
              <td>${e.role}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

function addNewEmployeePrompt() {
  const name = prompt("Enter Employee Name:");
  if (!name) return;
  const role = prompt("Enter Role/Designation:", "Software Engineer");
  
  const store = getStore();
  const newEmp = {
    id: "EMP00" + (store.employees.length + 1),
    name: name,
    email: name.toLowerCase().replace(/\s+/g, '.') + "@inxee.com",
    role: role || "Software Developer",
    department: "Engineering",
    joinDate: new Date().toISOString().split('T')[0],
    phone: "+91 98000 11223",
    avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80",
    salary: { base: 30000, allowance: 5000, deductions: 1500, net: 33500 }
  };
  store.employees.push(newEmp);
  saveStore(store);
  renderEmployeesAdminScreen();
}

function renderAdminSalaryScreen() {
  const store = getStore();
  
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-sack-dollar"></i> Employee Salary Management</div>
      <table class="data-table">
        <thead>
          <tr>
            <th>Employee</th>
            <th>Base</th>
            <th>Net Pay</th>
          </tr>
        </thead>
        <tbody>
          ${store.employees.map(e => `
            <tr>
              <td><strong>${e.name}</strong><br><span style="font-size: 11px; color: var(--text-muted);">${e.id}</span></td>
              <td>₹${e.salary.base.toLocaleString()}</td>
              <td style="font-weight: 700; color: #10b981;">₹${e.salary.net.toLocaleString()}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>
    </div>
  `;
}

function renderCheckInDetailsScreen() {
  renderAttendanceScreen();
}

function renderProfileScreen() {
  appContent.innerHTML = `
    <div class="card" style="text-align: center;">
      <img src="${currentUser.avatar}" style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; margin-bottom: 12px; border: 3px solid #000;">
      <h3 style="font-size: 18px; font-weight: 600;">${currentUser.name}</h3>
      <p style="font-size: 13px; color: var(--text-muted);">${currentUser.role}</p>
      
      <div style="margin-top: 20px; text-align: left; font-size: 13px;">
        <div style="padding: 10px 0; border-bottom: 1px solid var(--border);">
          <strong style="color: var(--text-muted);">Employee ID:</strong> ${currentUser.id}
        </div>
        <div style="padding: 10px 0; border-bottom: 1px solid var(--border);">
          <strong style="color: var(--text-muted);">Email:</strong> ${currentUser.email}
        </div>
        <div style="padding: 10px 0; border-bottom: 1px solid var(--border);">
          <strong style="color: var(--text-muted);">Phone:</strong> ${currentUser.phone || '+91 98765 43210'}
        </div>
        <div style="padding: 10px 0;">
          <strong style="color: var(--text-muted);">Department:</strong> ${currentUser.department || 'Engineering'}
        </div>
      </div>
    </div>
  `;
}

function renderReportScreen() {
  appContent.innerHTML = `
    <div class="card">
      <div class="card-title"><i class="fa-solid fa-headset"></i> System Help & Support Report</div>
      <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 16px;">Report an issue or request HR support using local offline storage.</p>
      
      <div class="form-group">
        <label>Subject</label>
        <input type="text" class="form-input" placeholder="Issue title...">
      </div>
      <div class="form-group">
        <label>Description</label>
        <textarea class="form-input" rows="4" placeholder="Describe your inquiry..."></textarea>
      </div>
      <button class="btn-primary" onclick="alert('Ticket logged successfully in local system dataset.'); renderHomeScreen();">SUBMIT REPORT</button>
    </div>
  `;
}

function logout() {
  currentUser = null;
  toggleDrawer();
  renderLoginScreen('employee');
}
