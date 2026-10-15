<%@ Page Title="Payments - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminPayments.aspx.cs" Inherits="FurniShop.AdminPayments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Payment Transactions & Audits</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Payment Method</th>
                            <th>Amount</th>
                            <th>Date</th>
                            <th>Payment Status</th>
                        </tr>
                    </thead>
                    <tbody id="admin-payments-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminPayments();
        });

        function renderAdminPayments() {
            const payments = db.get(DB_KEYS.PAYMENTS);
            const settings = db.getSettings();
            const tbody = document.getElementById('admin-payments-list');
            if (!tbody) return;

            if (payments.length === 0) {
                tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 3rem;">No payment records logged.</td></tr>`;
                return;
            }

            const statuses = ['Pending', 'Paid', 'Failed', 'Refunded'];

            tbody.innerHTML = payments.map(p => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size:0.85rem;">${p.id}</td>
                    <td style="font-weight:700;">${p.orderId}</td>
                    <td>${p.customerName}</td>
                    <td><i class="fa-solid fa-credit-card"></i> ${p.method}</td>
                    <td style="font-weight:800;">${settings.currency}${parseFloat(p.amount).toFixed(2)}</td>
                    <td>${p.date}</td>
                    <td>
                        <select onchange="updatePaymentStatusAction('${p.id}', this.value)" class="form-control" style="padding: 0.35rem; font-weight: 700; font-size:0.85rem;">
                            ${statuses.map(st => `<option value="${st}" ${p.status === st ? 'selected' : ''}>${st}</option>`).join('')}
                        </select>
                    </td>
                </tr>
            `).join('');
        }

        function updatePaymentStatusAction(payId, newStatus) {
            const payments = db.get(DB_KEYS.PAYMENTS);
            const p = payments.find(pay => pay.id === payId);
            if (p) {
                p.status = newStatus;
                db.set(DB_KEYS.PAYMENTS, payments);
                alert(`Payment ${payId} status updated to "${newStatus}".`);
                renderAdminPayments();
            }
        }
    </script>
</asp:Content>
