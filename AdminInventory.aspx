<%@ Page Title="Inventory - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminInventory.aspx.cs" Inherits="FurniShop.AdminInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Stock Inventory & Sold Metrics</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Product Item</th>
                            <th>Category</th>
                            <th>Available Stock</th>
                            <th>Sold Units</th>
                            <th>Inventory Status</th>
                            <th>Quick Restock</th>
                        </tr>
                    </thead>
                    <tbody id="admin-inventory-list">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderAdminInventory();
        });

        function renderAdminInventory() {
            const products = db.getProducts();
            const orders = db.getOrders();
            const settings = db.getSettings();
            const tbody = document.getElementById('admin-inventory-list');
            if (!tbody) return;

            const soldMap = {};
            orders.forEach(o => {
                o.items.forEach(i => {
                    soldMap[i.productId] = (soldMap[i.productId] || 0) + i.quantity;
                });
            });

            tbody.innerHTML = products.map(p => {
                const soldQty = soldMap[p.id] || 0;
                let statusBadge = 'instock';
                let statusText = 'In Stock';

                if (p.stock <= 0) {
                    statusBadge = 'outstock';
                    statusText = 'Out of Stock';
                } else if (p.stock <= settings.lowStockLimit) {
                    statusBadge = 'lowstock';
                    statusText = `Low Stock (${p.stock} left)`;
                }

                return `
                    <tr>
                        <td>
                            <div style="display:flex; align-items:center; gap: 0.75rem;">
                                <img src="${p.image}" alt="${p.name}" style="width:45px; height:35px; border-radius:4px; object-fit:cover;">
                                <div>
                                    <div style="font-weight:700;">${p.name}</div>
                                    <div style="font-size:0.75rem; color:var(--admin-text-muted);">${p.id}</div>
                                </div>
                            </div>
                        </td>
                        <td>${p.category}</td>
                        <td style="font-weight:700; font-size:1.1rem;">${p.stock}</td>
                        <td style="font-weight:700; color:var(--admin-accent);">${soldQty} units</td>
                        <td>${getStatusBadgeHtml(statusText)}</td>
                        <td>
                            <div style="display:flex; gap:0.35rem;">
                                <button type="button" onclick="quickAddStock('${p.id}', 5)" class="btn btn-outline btn-sm">+5 Stock</button>
                                <button type="button" onclick="quickAddStock('${p.id}', 10)" class="btn btn-accent btn-sm">+10 Stock</button>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function quickAddStock(id, qty) {
            const product = db.getProductById(id);
            if (product) {
                product.stock += qty;
                db.saveProduct(product);
                renderAdminInventory();
                alert(`Added +${qty} units to "${product.name}". New Stock: ${product.stock}`);
            }
        }
    </script>
</asp:Content>
