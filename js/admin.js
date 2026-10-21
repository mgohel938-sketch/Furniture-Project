/* ==========================================================================
   FURNISHOP - ADMIN PANEL SIDEBAR & TOPBAR CONTROLLER
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
    if (!window.location.pathname.toLowerCase().includes('adminlogin.aspx')) {
        renderAdminSidebar();
        renderAdminTopbar();
    }
});

function renderAdminSidebar() {
    const sidebarContainer = document.getElementById('admin-sidebar');
    if (!sidebarContainer) return;

    const currentPage = (window.location.pathname.split('/').pop() || 'AdminDashboard.aspx').toLowerCase();

    const menuItems = [
        { label: 'Core', items: [
            { page: 'AdminDashboard.aspx', icon: 'fa-chart-pie', text: 'Dashboard' },
            { page: 'AdminProducts.aspx', icon: 'fa-couch', text: 'Products / Furniture' },
            { page: 'AdminAddProduct.aspx', icon: 'fa-plus', text: 'Add Product' },
            { page: 'AdminCategories.aspx', icon: 'fa-list', text: 'Categories' }
        ]},
        { label: 'Sales & Orders', items: [
            { page: 'AdminOrders.aspx', icon: 'fa-receipt', text: 'Orders' },
            { page: 'AdminCustomers.aspx', icon: 'fa-users', text: 'Customers' }
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
            <a href="AdminLogin.aspx" class="admin-link" style="width: 100%; color: #ff6b6b;">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </a>
        </div>
        </div>
    `;

    sidebarContainer.innerHTML = html;
}

function renderAdminTopbar() {
    const topbarContainer = document.getElementById('admin-topbar');
    if (!topbarContainer) return;

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
                <div class="admin-avatar">A</div>
                <div>
                    <div style="font-weight:700; font-size: 0.9rem;">Admin</div>
                    <div style="font-size: 0.75rem; color: var(--admin-text-muted);">Administrator</div>
                </div>
            </div>
        </div>
    `;
}

function getStatusBadgeHtml(status) {
    const lower = (status || '').toLowerCase().replace(/\s+/g, '');
    return `<span class="status-badge ${lower}">${status}</span>`;
}
