<%@ Page Title="Customers - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCustomers.aspx.cs" Inherits="FurniShop.AdminCustomers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Customer Accounts & Lifetime Value</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Total Orders</th>
                            <th>Total Spending</th>
                            <th>Account Status</th>
                        </tr>
                    </thead>
                    <tbody id="admin-customers-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminCustomers();
        });

        function renderAdminCustomers() {
            const users = db.getUsers();
            const settings = db.getSettings();
            const tbody = document.getElementById('admin-customers-list');
            if (!tbody) return;

            if (users.length === 0) {
                tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 3rem;">No customer accounts registered yet.</td></tr>`;
                return;
            }

            tbody.innerHTML = users.map(u => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size:0.85rem;">${u.id}</td>
                    <td style="font-weight:700;">${u.name}</td>
                    <td>${u.email}</td>
                    <td>${u.phone || 'N/A'}</td>
                    <td style="font-weight:700;">${u.ordersCount || 0} orders</td>
                    <td style="font-weight:700; color: #2e7d32;">${settings.currency}${parseFloat(u.totalSpent || 0).toLocaleString(undefined, {minimumFractionDigits:2})}</td>
                    <td>${getStatusBadgeHtml(u.status || 'Active')}</td>
                </tr>
            `).join('');
        }
    </script>
</asp:Content>
