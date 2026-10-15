<%@ Page Title="Sales Ledger - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSales.aspx.cs" Inherits="FurniShop.AdminSales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Financial Sales Ledger</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Sale ID</th>
                            <th>Order ID</th>
                            <th>Customer Name</th>
                            <th>Items Count</th>
                            <th>Gross Sale Amount</th>
                            <th>Transaction Date</th>
                        </tr>
                    </thead>
                    <tbody id="admin-sales-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminSales();
        });

        function renderAdminSales() {
            const sales = db.get(DB_KEYS.SALES);
            const settings = db.getSettings();
            const tbody = document.getElementById('admin-sales-list');
            if (!tbody) return;

            if (sales.length === 0) {
                tbody.innerHTML = `<tr><td colspan="6" style="text-align:center; padding: 3rem;">No sales records logged yet.</td></tr>`;
                return;
            }

            tbody.innerHTML = sales.map(s => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size:0.85rem;">${s.id}</td>
                    <td style="font-weight:700;">${s.orderId}</td>
                    <td>${s.customerName}</td>
                    <td>${s.itemCount || 1} items</td>
                    <td style="font-weight:800; color:#2e7d32;">${settings.currency}${parseFloat(s.amount).toFixed(2)}</td>
                    <td>${s.date}</td>
                </tr>
            `).join('');
        }
    </script>
</asp:Content>
