<%@ Page Title="Suppliers - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSuppliers.aspx.cs" Inherits="FurniShop.AdminSuppliers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="display: grid; grid-template-columns: 1fr 360px; gap: 2rem;">
        <div class="admin-card">
            <div class="admin-card-header">
                <h2>Supplier Directory & Artisanal Partners</h2>
            </div>
            <div class="admin-card-body" style="padding: 0;">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Contact Name</th>
                                <th>Company</th>
                                <th>Phone / Email</th>
                                <th>Location</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-suppliers-body">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="admin-card" style="height: fit-content;">
            <div class="admin-card-header">
                <h2 id="sup-form-title">Add New Supplier</h2>
            </div>
            <div class="admin-card-body">
                <div id="sup-form">
                    <input type="hidden" id="sup-id">

                    <div class="form-group">
                        <label class="form-label">Contact Name *</label>
                        <input type="text" id="sup-name" class="form-control" required placeholder="e.g. Marco Bellini">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Company Name *</label>
                        <input type="text" id="sup-company" class="form-control" required placeholder="e.g. Bellini Leather S.p.A">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" id="sup-phone" class="form-control" placeholder="+39 02 555-019">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" id="sup-email" class="form-control" placeholder="marco@bellini.it">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Address / Origin</label>
                        <input type="text" id="sup-address" class="form-control" placeholder="Florence, Italy">
                    </div>

                    <div style="display: flex; gap: 0.5rem;">
                        <button type="button" onclick="handleSupplierSave()" class="btn btn-accent btn-sm" style="flex:1;">Save Supplier</button>
                        <button type="button" onclick="resetSupForm()" class="btn btn-outline btn-sm">Reset</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminSuppliers();
        });

        function renderAdminSuppliers() {
            const suppliers = db.getSuppliers();
            const tbody = document.getElementById('admin-suppliers-body');
            if (!tbody) return;

            tbody.innerHTML = suppliers.map(s => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size:0.85rem;">${s.id}</td>
                    <td style="font-weight:700;">${s.name}</td>
                    <td>${s.company}</td>
                    <td>
                        <div>${s.phone || ''}</div>
                        <div style="font-size:0.75rem; color:var(--admin-text-muted);">${s.email || ''}</div>
                    </td>
                    <td>${s.address || 'Europe'}</td>
                    <td>
                        <div class="action-btn-group">
                            <button type="button" onclick="editSupplierAction('${s.id}')" class="btn-icon btn-icon-edit" title="Edit"><i class="fa-solid fa-pen"></i></button>
                            <button type="button" onclick="deleteSupplierAction('${s.id}', '${s.name}')" class="btn-icon btn-icon-delete" title="Delete"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </td>
                </tr>
            `).join('');
        }

        function editSupplierAction(id) {
            const s = db.getSuppliers().find(sup => sup.id === id);
            if (!s) return;
            document.getElementById('sup-form-title').textContent = 'Edit Supplier';
            document.getElementById('sup-id').value = s.id;
            document.getElementById('sup-name').value = s.name;
            document.getElementById('sup-company').value = s.company;
            document.getElementById('sup-phone').value = s.phone || '';
            document.getElementById('sup-email').value = s.email || '';
            document.getElementById('sup-address').value = s.address || '';
        }

        function resetSupForm() {
            document.getElementById('sup-form-title').textContent = 'Add New Supplier';
            document.getElementById('sup-id').value = '';
            document.getElementById('sup-name').value = '';
            document.getElementById('sup-company').value = '';
            document.getElementById('sup-phone').value = '';
            document.getElementById('sup-email').value = '';
            document.getElementById('sup-address').value = '';
        }

        function handleSupplierSave() {
            const name = document.getElementById('sup-name').value;
            const company = document.getElementById('sup-company').value;

            if (!name || !company) {
                alert('Please fill out Name and Company');
                return;
            }

            const supplier = {
                id: document.getElementById('sup-id').value || 'sup-' + Date.now(),
                name: name,
                company: company,
                phone: document.getElementById('sup-phone').value,
                email: document.getElementById('sup-email').value,
                address: document.getElementById('sup-address').value
            };
            db.saveSupplier(supplier);
            alert(`Supplier "${supplier.name}" saved! Available for product assignment.`);
            resetSupForm();
            renderAdminSuppliers();
        }

        function deleteSupplierAction(id, name) {
            if (confirm(`Delete supplier "${name}"?`)) {
                db.deleteSupplier(id);
                renderAdminSuppliers();
            }
        }
    </script>
</asp:Content>
