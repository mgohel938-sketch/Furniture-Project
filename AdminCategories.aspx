<%@ Page Title="Categories - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategories.aspx.cs" Inherits="FurniShop.AdminCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="display: grid; grid-template-columns: 1fr 380px; gap: 2rem;">
        <div class="admin-card">
            <div class="admin-card-header">
                <h2>Furniture Categories Directory</h2>
            </div>
            <div class="admin-card-body" style="padding: 0;">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Icon</th>
                                <th>Category Name</th>
                                <th>Items Count</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-categories-body">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="admin-card" style="height: fit-content;">
            <div class="admin-card-header">
                <h2 id="cat-form-title">Add New Category</h2>
            </div>
            <div class="admin-card-body">
                <div id="cat-form">
                    <input type="hidden" id="cat-id">

                    <div class="form-group">
                        <label class="form-label">Category Name *</label>
                        <input type="text" id="cat-name" class="form-control" required placeholder="e.g. Lighting & Lamps">
                    </div>

                    <div class="form-group">
                        <label class="form-label">FontAwesome Icon Class</label>
                        <input type="text" id="cat-icon" class="form-control" placeholder="fa-couch" value="fa-tag">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Image URL</label>
                        <input type="url" id="cat-image" class="form-control" required placeholder="https://images.unsplash.com/...">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea id="cat-desc" class="form-control" rows="3" placeholder="Brief summary of category..."></textarea>
                    </div>

                    <div style="display: flex; gap: 0.5rem;">
                        <button type="button" onclick="handleCategorySave()" class="btn btn-accent btn-sm" style="flex:1;">Save Category</button>
                        <button type="button" onclick="resetCatForm()" class="btn btn-outline btn-sm">Reset</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminCategories();
        });

        function renderAdminCategories() {
            const categories = db.getCategories();
            const products = db.getProducts();
            const tbody = document.getElementById('admin-categories-body');
            if (!tbody) return;

            tbody.innerHTML = categories.map(cat => {
                const count = products.filter(p => p.category === cat.name).length;
                return `
                    <tr>
                        <td style="font-size: 1.2rem; color: var(--admin-accent);"><i class="fa-solid ${cat.icon || 'fa-tag'}"></i></td>
                        <td style="font-weight: 700;">${cat.name}</td>
                        <td style="font-weight: 700;">${count} products</td>
                        <td style="font-size: 0.85rem; color: var(--admin-text-muted);">${cat.description || ''}</td>
                        <td>
                            <div class="action-btn-group">
                                <button type="button" onclick="editCategory('${cat.id}')" class="btn-icon btn-icon-edit" title="Edit"><i class="fa-solid fa-pen"></i></button>
                                <button type="button" onclick="deleteCategoryAction('${cat.id}', '${cat.name}')" class="btn-icon btn-icon-delete" title="Delete"><i class="fa-solid fa-trash"></i></button>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function editCategory(id) {
            const categories = db.getCategories();
            const cat = categories.find(c => c.id === id);
            if (!cat) return;

            document.getElementById('cat-form-title').textContent = 'Edit Category';
            document.getElementById('cat-id').value = cat.id;
            document.getElementById('cat-name').value = cat.name;
            document.getElementById('cat-icon').value = cat.icon || 'fa-tag';
            document.getElementById('cat-image').value = cat.image || '';
            document.getElementById('cat-desc').value = cat.description || '';
        }

        function resetCatForm() {
            document.getElementById('cat-form-title').textContent = 'Add New Category';
            document.getElementById('cat-id').value = '';
            document.getElementById('cat-name').value = '';
            document.getElementById('cat-icon').value = 'fa-tag';
            document.getElementById('cat-image').value = '';
            document.getElementById('cat-desc').value = '';
        }

        function handleCategorySave() {
            const id = document.getElementById('cat-id').value || 'cat-' + Date.now();
            const name = document.getElementById('cat-name').value;
            const icon = document.getElementById('cat-icon').value;
            const image = document.getElementById('cat-image').value;
            const desc = document.getElementById('cat-desc').value;

            if (!name) {
                alert('Please enter category name');
                return;
            }

            db.saveCategory({ id, name, icon, image, description: desc });
            alert(`Category "${name}" saved! Syncs to Customer Categories & Shop Filter.`);
            resetCatForm();
            renderAdminCategories();
        }

        function deleteCategoryAction(id, name) {
            if (confirm(`Delete category "${name}"?`)) {
                db.deleteCategory(id);
                renderAdminCategories();
            }
        }
    </script>
</asp:Content>
