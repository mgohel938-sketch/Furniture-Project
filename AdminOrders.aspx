<%@ Page Title="Orders - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="FurniShop.AdminOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Customer Order Management & Dispatch</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer Details</th>
                            <th>Items Ordered</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Payment</th>
                            <th>Order Status (Live Sync)</th>
                        </tr>
                    </thead>
                    <tbody id="admin-orders-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminOrders();
        });

        function renderAdminOrders() {
            const orders = db.getOrders();
            const settings = db.getSettings();
            const tbody = document.getElementById('admin-orders-list');
            if (!tbody) return;

            if (orders.length === 0) {
                tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 3rem;">No customer orders placed yet.</td></tr>`;
                return;
            }

            const statuses = ['Pending', 'Confirmed', 'Processing', 'Shipped', 'Delivered', 'Cancelled'];

            tbody.innerHTML = orders.map(o => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size: 0.85rem;">${o.id}</td>
                    <td>
                        <div style="font-weight:700;">${o.customerName}</div>
                        <div style="font-size:0.75rem; color:var(--admin-text-muted);">${o.customerEmail}</div>
                    </td>
                    <td>
                        <div style="font-size:0.85rem; max-width: 250px;">
                            ${o.items.map(i => `${i.name} (x${i.quantity})`).join(', ')}
                        </div>
                    </td>
                    <td>${o.date}</td>
                    <td style="font-weight:700;">${settings.currency}${o.total}</td>
                    <td>
                        <span style="font-size:0.8rem; font-weight:600;">${o.paymentMethod}</span>
                        <div style="font-size:0.75rem; color:var(--admin-text-muted);">${o.paymentStatus}</div>
                    </td>
                    <td>
                        <select onchange="updateOrderStatusAction('${o.id}', this.value)" class="form-control" style="padding: 0.4rem; font-size: 0.85rem; font-weight: 700;">
                            ${statuses.map(s => `<option value="${s}" ${o.orderStatus === s ? 'selected' : ''}>${s}</option>`).join('')}
                        </select>
                    </td>
                </tr>
            `).join('');
        }

        function updateOrderStatusAction(orderId, newStatus) {
            db.updateOrderStatus(orderId, newStatus);
            alert(`Order ${orderId} updated to status "${newStatus}".\nThis status immediately updates on Customer "My Orders" page.`);
            renderAdminOrders();
        }
    </script>
</asp:Content>
