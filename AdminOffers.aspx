<%@ Page Title="Offers & Discounts - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOffers.aspx.cs" Inherits="FurniShop.AdminOffers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="display: grid; grid-template-columns: 1fr 380px; gap: 2rem;">
        <div class="admin-card">
            <div class="admin-card-header">
                <h2>Active Promotional Offers</h2>
            </div>
            <div class="admin-card-body" style="padding: 0;">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Offer Name</th>
                                <th>Discount %</th>
                                <th>Target Category</th>
                                <th>Duration</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-offers-list">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="admin-card" style="height: fit-content;">
            <div class="admin-card-header">
                <h2>Create Promotional Offer</h2>
            </div>
            <div class="admin-card-body">
                <div id="offer-form">
                    <div class="form-group">
                        <label class="form-label">Offer Name *</label>
                        <input type="text" id="off-name" class="form-control" required placeholder="e.g. VIP Autumn Special">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Discount Percentage (%) *</label>
                        <input type="number" id="off-discount" class="form-control" required min="1" max="90" placeholder="15">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Applicable Category *</label>
                        <select id="off-category" class="form-control" required>
                        </select>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label class="form-label">Start Date</label>
                            <input type="date" id="off-start" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">End Date</label>
                            <input type="date" id="off-end" class="form-control" required>
                        </div>
                    </div>

                    <button type="button" onclick="handleOfferSave()" class="btn btn-accent btn-sm" style="width: 100%;">Create & Activate Offer</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            populateCategories();
            renderAdminOffers();
            
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('off-start').value = today;
        });

        function populateCategories() {
            const select = document.getElementById('off-category');
            select.innerHTML = db.getCategories().map(c => `<option value="${c.name}">${c.name}</option>`).join('');
        }

        function renderAdminOffers() {
            const offers = db.getOffers();
            const tbody = document.getElementById('admin-offers-list');
            if (!tbody) return;

            if (offers.length === 0) {
                tbody.innerHTML = `<tr><td colspan="6" style="text-align:center; padding: 3rem;">No active promotional offers.</td></tr>`;
                return;
            }

            tbody.innerHTML = offers.map(o => `
                <tr>
                    <td style="font-weight:700;">${o.name}</td>
                    <td style="font-weight:800; color:var(--admin-accent);">${o.discount}% OFF</td>
                    <td>${o.category}</td>
                    <td style="font-size:0.8rem; color:var(--admin-text-muted);">${o.startDate} to ${o.endDate}</td>
                    <td>${getStatusBadgeHtml(o.status)}</td>
                    <td>
                        <button type="button" onclick="deleteOfferAction('${o.id}')" class="btn-icon btn-icon-delete" title="Delete"><i class="fa-solid fa-trash"></i></button>
                    </td>
                </tr>
            `).join('');
        }

        function handleOfferSave() {
            const name = document.getElementById('off-name').value;
            const discount = document.getElementById('off-discount').value;
            const category = document.getElementById('off-category').value;
            const startDate = document.getElementById('off-start').value;
            const endDate = document.getElementById('off-end').value;

            if (!name || !discount) {
                alert('Please fill out offer name and discount');
                return;
            }

            const newOffer = {
                id: 'off-' + Date.now(),
                name: name,
                discount: parseFloat(discount),
                category: category,
                startDate: startDate,
                endDate: endDate,
                status: 'Active'
            };

            db.saveOffer(newOffer);

            const products = db.getProducts();
            products.forEach(p => {
                if (p.category === newOffer.category) {
                    p.discount = newOffer.discount;
                }
            });
            db.set(DB_KEYS.PRODUCTS, products);

            alert(`Offer "${newOffer.name}" created! Applied ${newOffer.discount}% discount to all "${newOffer.category}" products on the Customer Shop page.`);
            renderAdminOffers();
            document.getElementById('off-name').value = '';
            document.getElementById('off-discount').value = '';
        }

        function deleteOfferAction(id) {
            if (confirm('Delete this promotional offer?')) {
                db.deleteOffer(id);
                renderAdminOffers();
            }
        }
    </script>
</asp:Content>
