/* ==========================================================================
   FURNISHOP - ADMIN PANEL LOGIC & SIDEBAR CONTROLLER (ASP.NET ASPX)
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
    // Exclude login page from auth check and layout rendering
    if (!window.location.pathname.toLowerCase().includes('adminlogin.aspx')) {
        checkAdminAuth();
        renderAdminSidebar();
        renderAdminTopbar();
    }
});

function checkAdminAuth() {
    const session = db.getAdminSession();
    if (!session) {
        window.location.href = 'AdminLogin.aspx';
    }
}

function renderAdminSidebar() {
    const sidebarContainer = document.getElementById('admin-sidebar');
    if (!sidebarContainer) return;

    const currentPage = (window.location.pathname.split('/').pop() || 'AdminDashboard.aspx').toLowerCase();

    const menuItems = [
        { label: 'Core', items: [
            { page: 'AdminDashboard.aspx', icon: 'fa-chart-pie', text: 'Dashboard' },
            { page: 'AdminProducts.aspx', icon: 'fa-couch', text: 'Products / Furniture' },
            { page: 'AdminCategories.aspx', icon: 'fa-list', text: 'Categories' },
            { page: 'AdminInventory.aspx', icon: 'fa-boxes-stacked', text: 'Inventory' },
            { page: 'AdminSuppliers.aspx', icon: 'fa-truck-field', text: 'Suppliers' }
        ]},
        { label: 'Sales & Orders', items: [
            { page: 'AdminOrders.aspx', icon: 'fa-receipt', text: 'Orders' },
            { page: 'AdminCustomers.aspx', icon: 'fa-users', text: 'Customers' },
            { page: 'AdminSales.aspx', icon: 'fa-chart-line', text: 'Sales Record' },
            { page: 'AdminPayments.aspx', icon: 'fa-credit-card', text: 'Payments' }
        ]},
        { label: 'Marketing & Reviews', items: [
            { page: 'AdminOffers.aspx', icon: 'fa-tags', text: 'Promotions & Offers' },
            { page: 'AdminReviews.aspx', icon: 'fa-star', text: 'Customer Reviews' },
            { page: 'AdminReports.aspx', icon: 'fa-file-invoice-dollar', text: 'Analytics Reports' }
        ]},
        { label: 'System', items: [
            { page: 'AdminProfile.aspx', icon: 'fa-user-gear', text: 'Admin Profile' },
            { page: 'AdminSettings.aspx', icon: 'fa-sliders', text: 'Global Settings' }
        ]}
    ];

    let html = `
        <div class="admin-brand">
            <i class="fa-solid fa-couch"></i> Furni<span>Shop</span> Admin
        </div>
        <div class="admin-menu">
    `;

    menuItems.forEach(group => {
        html += `<div class="admin-menu-label">${group.label}</div>`;
        group.items.forEach(item => {
            const isActive = currentPage === item.page.toLowerCase();
            html += `
                <a href="${item.page}" class="admin-link ${isActive ? 'active' : ''}">
                    <i class="fa-solid ${item.icon}"></i>
                    <span>${item.text}</span>
                </a>
            `;
        });
    });

    html += `
        <div style="margin-top: auto; padding: 1rem 0.75rem;">
            <button type="button" onclick="handleAdminLogout()" class="admin-link" style="width: 100%; color: #ff6b6b; background: none; border: none; cursor: pointer;">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </button>
        </div>
        </div>
    `;

    sidebarContainer.innerHTML = html;
}

function renderAdminTopbar() {
    const topbarContainer = document.getElementById('admin-topbar');
    if (!topbarContainer) return;

    const session = db.getAdminSession() || { name: 'Admin User', role: 'Super Admin' };
    const pageTitle = document.title.split('-')[0].trim();

    topbarContainer.innerHTML = `
        <div class="admin-topbar-title">
            <h1>${pageTitle}</h1>
        </div>
        <div class="admin-topbar-actions">
            <a href="Index.aspx" target="_blank" class="btn btn-outline btn-sm">
                <i class="fa-solid fa-external-link"></i> View Customer Store
            </a>
            <div class="admin-user-profile">
                <div class="admin-avatar">
                    ${session.name.charAt(0)}
                </div>
                <div>
                    <div style="font-weight:700; font-size: 0.9rem;">${session.name}</div>
                    <div style="font-size: 0.75rem; color: var(--admin-text-muted);">${session.role}</div>
                </div>
            </div>
        </div>
    `;
}

function handleAdminLogout() {
    db.logoutAdmin();
    window.location.href = 'AdminLogin.aspx';
}

function getStatusBadgeHtml(status) {
    const lower = (status || '').toLowerCase().replace(/\s+/g, '');
    return `<span class="status-badge ${lower}">${status}</span>`;
}
