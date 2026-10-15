<%@ Page Title="Products Management - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="FurniShop.AdminProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Furniture Catalog Management</h2>
            <a href="AdminAddProduct.aspx" class="btn btn-accent btn-sm">
                <i class="fa-solid fa-plus"></i> Add New Product
            </a>
        </div>

        <div style="padding: 1.25rem 1.75rem; background: #fafafa; border-bottom: 1px solid var(--admin-border); display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <div style="flex-grow: 1; max-width: 350px;">
                <input type="text" id="admin-product-search" class="form-control" placeholder="Search product name or ID..." onkeyup="filterAdminProducts()">
            </div>
            <div>
                <select id="admin-product-category" class="form-control" onchange="filterAdminProducts()">
                    <option value="All">All Categories</option>
                </select>
            </div>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock Qty</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="admin-products-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            populateCategoryDropdown();
            renderAdminProducts();
        });

        function populateCategoryDropdown() {
            const select = document.getElementById('admin-product-category');
            if (!select) return;
            const categories = db.getCategories();
            categories.forEach(c => {
                const opt = document.createElement('option');
                opt.value = c.name;
                opt.textContent = c.name;
                select.appendChild(opt);
            });
        }

        function filterAdminProducts() {
            const query = document.getElementById('admin-product-search').value.toLowerCase();
            const category = document.getElementById('admin-product-category').value;
            renderAdminProducts(query, category);
        }

        function renderAdminProducts(query = '', catFilter = 'All') {
            let products = db.getProducts();
            const tbody = document.getElementById('admin-products-list');
            if (!tbody) return;

            if (query) {
                products = products.filter(p => p.name.toLowerCase().includes(query) || p.id.toLowerCase().includes(query));
            }
            if (catFilter !== 'All') {
                products = products.filter(p => p.category === catFilter);
            }

            if (products.length === 0) {
                tbody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 3rem;">No furniture products found.</td></tr>`;
                return;
            }

            const settings = db.getSettings();

            tbody.innerHTML = products.map(p => `
                <tr>
                    <td style="font-weight:700; color:var(--admin-accent); font-size: 0.85rem;">${p.id}</td>
                    <td>
                        <img src="${p.image}" alt="${p.name}" style="width: 50px; height: 40px; border-radius: 4px; object-fit: cover;">
                    </td>
                    <td style="font-weight: 700;">${p.name}</td>
                    <td>${p.category}</td>
                    <td style="font-weight: 700;">${settings.currency}${p.price}</td>
                    <td style="font-weight: 700;">${p.stock}</td>
                    <td>
                        <span class="status-badge ${p.stock <= 0 ? 'outstock' : (p.stock <= settings.lowStockLimit ? 'lowstock' : 'instock')}">
                            ${p.stock <= 0 ? 'Out of Stock' : (p.stock <= settings.lowStockLimit ? 'Low Stock' : 'In Stock')}
                        </span>
                    </td>
                    <td>
                        <div class="action-btn-group">
                            <a href="AdminEditProduct.aspx?id=${p.id}" class="btn-icon btn-icon-edit" title="Edit"><i class="fa-solid fa-pen"></i></a>
                            <button type="button" onclick="confirmDeleteProduct('${p.id}', '${p.name.replace(/'/g, "\\'")}')" class="btn-icon btn-icon-delete" title="Delete"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </td>
                </tr>
            `).join('');
        }

        function confirmDeleteProduct(id, name) {
            if (confirm(`Are you sure you want to permanently delete "${name}"?\nThis will automatically remove it from the Customer Shop page.`)) {
                db.deleteProduct(id);
                renderAdminProducts();
                alert(`Product "${name}" deleted successfully.`);
            }
        }
    </script>
</asp:Content>
