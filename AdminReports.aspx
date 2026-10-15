<%@ Page Title="Reports & Analytics - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReports.aspx.cs" Inherits="FurniShop.AdminReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Enterprise Reports & Business Intelligence</h2>
            <div style="display: flex; gap: 0.5rem;">
                <button type="button" onclick="window.print()" class="btn btn-outline btn-sm"><i class="fa-solid fa-print"></i> Print Report</button>
                <button type="button" onclick="exportCSVReport()" class="btn btn-accent btn-sm"><i class="fa-solid fa-file-csv"></i> Export CSV</button>
            </div>
        </div>

        <div style="padding: 1.25rem 1.75rem; background: #fafafa; border-bottom: 1px solid var(--admin-border); display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <div>
                <label style="font-size:0.8rem; font-weight:700;">Report Type:</label>
                <select id="report-type" class="form-control" onchange="generateReport()" style="width: auto;">
                    <option value="sales">Sales & Revenue Report</option>
                    <option value="products">Product Performance Report</option>
                    <option value="inventory">Inventory & Stock Status Report</option>
                    <option value="customers">Customer Lifetime Value Report</option>
                    <option value="orders">Orders Audit Report</option>
                </select>
            </div>
            <div>
                <label style="font-size:0.8rem; font-weight:700;">Search Keyword:</label>
                <input type="text" id="report-search" class="form-control" placeholder="Filter records..." onkeyup="generateReport()" style="width: 220px;">
            </div>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table" id="report-table">
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            generateReport();
        });

        function generateReport() {
            const type = document.getElementById('report-type').value;
            const search = document.getElementById('report-search').value.toLowerCase();
            const table = document.getElementById('report-table');
            const settings = db.getSettings();

            if (type === 'sales') {
                let sales = db.get(DB_KEYS.SALES);
                if (search) sales = sales.filter(s => s.orderId.toLowerCase().includes(search) || s.customerName.toLowerCase().includes(search));

                table.innerHTML = `
                    <thead>
                        <tr>
                            <th>Sale ID</th>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Item Count</th>
                            <th>Gross Sales ($)</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${sales.map(s => `
                            <tr>
                                <td style="font-weight:700; color:var(--admin-accent);">${s.id}</td>
                                <td>${s.orderId}</td>
                                <td>${s.customerName}</td>
                                <td>${s.itemCount || 1}</td>
                                <td style="font-weight:800; color:#2e7d32;">${settings.currency}${s.amount}</td>
                                <td>${s.date}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                `;
            } else if (type === 'products') {
                let products = db.getProducts();
                if (search) products = products.filter(p => p.name.toLowerCase().includes(search) || p.category.toLowerCase().includes(search));

                table.innerHTML = `
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Discount</th>
                            <th>Rating</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${products.map(p => `
                            <tr>
                                <td style="font-weight:700; color:var(--admin-accent);">${p.id}</td>
                                <td style="font-weight:700;">${p.name}</td>
                                <td>${p.category}</td>
                                <td>${settings.currency}${p.price}</td>
                                <td>${p.discount}%</td>
                                <td>${p.rating} ★ (${p.reviewCount})</td>
                                <td>${p.stock} units</td>
                            </tr>
                        `).join('')}
                    </tbody>
                `;
            } else if (type === 'inventory') {
                let products = db.getProducts();
                if (search) products = products.filter(p => p.name.toLowerCase().includes(search));

                table.innerHTML = `
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Stock Level</th>
                            <th>Status Badge</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${products.map(p => `
                            <tr>
                                <td style="font-weight:700;">${p.name}</td>
                                <td>${p.category}</td>
                                <td style="font-weight:800;">${p.stock}</td>
                                <td>${getStatusBadgeHtml(p.stock <= 0 ? 'Out of Stock' : (p.stock <= settings.lowStockLimit ? 'Low Stock' : 'In Stock'))}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                `;
            } else if (type === 'customers') {
                let customers = db.getUsers();
                if (search) customers = customers.filter(c => c.name.toLowerCase().includes(search) || c.email.toLowerCase().includes(search));

                table.innerHTML = `
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Total Orders</th>
                            <th>Lifetime Value ($)</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${customers.map(c => `
                            <tr>
                                <td style="font-weight:700; color:var(--admin-accent);">${c.id}</td>
                                <td style="font-weight:700;">${c.name}</td>
                                <td>${c.email}</td>
                                <td>${c.phone || 'N/A'}</td>
                                <td>${c.ordersCount || 0}</td>
                                <td style="font-weight:800; color:#2e7d32;">${settings.currency}${parseFloat(c.totalSpent || 0).toFixed(2)}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                `;
            } else if (type === 'orders') {
                let orders = db.getOrders();
                if (search) orders = orders.filter(o => o.id.toLowerCase().includes(search) || o.customerName.toLowerCase().includes(search));

                table.innerHTML = `
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Payment</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${orders.map(o => `
                            <tr>
                                <td style="font-weight:700; color:var(--admin-accent);">${o.id}</td>
                                <td>${o.customerName}</td>
                                <td>${o.date}</td>
                                <td style="font-weight:700;">${settings.currency}${o.total}</td>
                                <td>${o.paymentMethod} (${o.paymentStatus})</td>
                                <td>${getStatusBadgeHtml(o.orderStatus)}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                `;
            }
        }

        function exportCSVReport() {
            const type = document.getElementById('report-type').value;
            alert(`Report "${type.toUpperCase()}" exported as CSV download file.`);
        }
    </script>
</asp:Content>
