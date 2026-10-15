<%@ Page Title="Customer Reviews - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReviews.aspx.cs" Inherits="FurniShop.AdminReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Customer Product Review Moderation</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Customer</th>
                            <th>Product</th>
                            <th>Rating</th>
                            <th>Comment</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Moderation Actions</th>
                        </tr>
                    </thead>
                    <tbody id="admin-reviews-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminReviews();
        });

        function renderAdminReviews() {
            const reviews = db.getReviews();
            const products = db.getProducts();
            const tbody = document.getElementById('admin-reviews-list');
            if (!tbody) return;

            if (reviews.length === 0) {
                tbody.innerHTML = `<tr><td colspan="7" style="text-align:center; padding: 3rem;">No customer reviews submitted yet.</td></tr>`;
                return;
            }

            tbody.innerHTML = reviews.map(r => {
                const prod = products.find(p => p.id === r.productId);
                const prodName = prod ? prod.name : r.productId;
                return `
                    <tr>
                        <td style="font-weight:700;">${r.customerName}</td>
                        <td style="font-size:0.85rem; max-width: 180px;">${prodName}</td>
                        <td style="color:#eab308; white-space:nowrap;">
                            ${'<i class="fa-solid fa-star"></i>'.repeat(r.rating)}
                        </td>
                        <td style="font-size:0.85rem; max-width: 300px; color: var(--admin-text-muted);">${r.comment}</td>
                        <td style="font-size:0.8rem;">${r.date}</td>
                        <td>${getStatusBadgeHtml(r.status)}</td>
                        <td>
                            <div class="action-btn-group">
                                ${r.status !== 'Approved' ? `<button type="button" onclick="setReviewStatusAction('${r.id}', 'Approved')" class="btn btn-outline btn-sm" style="color:green;"><i class="fa-solid fa-check"></i> Approve</button>` : ''}
                                ${r.status !== 'Hidden' ? `<button type="button" onclick="setReviewStatusAction('${r.id}', 'Hidden')" class="btn btn-outline btn-sm" style="color:orange;"><i class="fa-solid fa-eye-slash"></i> Hide</button>` : ''}
                                <button type="button" onclick="deleteReviewAction('${r.id}')" class="btn-icon btn-icon-delete" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function setReviewStatusAction(id, status) {
            db.updateReviewStatus(id, status);
            alert(`Review status set to "${status}". Only approved reviews show on product pages.`);
            renderAdminReviews();
        }

        function deleteReviewAction(id) {
            if (confirm('Delete this review permanently?')) {
                db.deleteReview(id);
                renderAdminReviews();
            }
        }
    </script>
</asp:Content>
