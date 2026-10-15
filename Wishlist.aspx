<%@ Page Title="FurniShop - Saved Wishlist" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="FurniShop.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">My Wishlist Sanctuary</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Wishlist</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div id="wishlist-container">
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderWishlist();
        });

        function renderWishlist() {
            const wishlistIds = db.getWishlist();
            const container = document.getElementById('wishlist-container');
            if (!container) return;

            if (wishlistIds.length === 0) {
                container.innerHTML = `
                    <div style="text-align: center; padding: 4rem 1rem;">
                        <i class="fa-regular fa-heart" style="font-size: 4rem; color: var(--clr-text-light); margin-bottom: 1.5rem;"></i>
                        <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">Your Wishlist is Empty</h2>
                        <p style="color: var(--clr-text-muted); margin-bottom: 2rem;">Save your favorite luxury items to review or add to cart later.</p>
                        <a href="Shop.aspx" class="btn btn-primary btn-lg">Explore Shop Collection</a>
                    </div>
                `;
                return;
            }

            const products = db.getProducts().filter(p => wishlistIds.includes(p.id));

            container.innerHTML = `
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                    <h3>Saved Items (${products.length})</h3>
                    <a href="Shop.aspx" class="btn btn-outline btn-sm">Continue Shopping <i class="fa-solid fa-arrow-right"></i></a>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${products.map(prod => {
                                const finalPrice = prod.discount ? prod.price * (1 - prod.discount/100) : prod.price;
                                return `
                                    <tr>
                                        <td>
                                            <div style="display: flex; align-items: center; gap: 1rem;">
                                                <img src="${prod.image}" alt="${prod.name}" style="width: 80px; height: 60px; border-radius: var(--radius-sm); object-fit: cover;">
                                                <div>
                                                    <a href="ProductDetails.aspx?id=${prod.id}" style="font-weight: 700; color: var(--clr-text-main);">${prod.name}</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${prod.category}</td>
                                        <td style="font-weight: 700;">${formatPrice(finalPrice)}</td>
                                        <td>
                                            <span style="font-weight:600; color:${prod.stock > 0 ? 'var(--clr-success)' : 'var(--clr-danger)'}">
                                                ${prod.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                            </span>
                                        </td>
                                        <td>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <button type="button" onclick="moveToCart('${prod.id}')" class="btn btn-primary btn-sm" ${prod.stock <= 0 ? 'disabled style="opacity:0.5;"' : ''}>
                                                    <i class="fa-solid fa-bag-shopping"></i> Add to Cart
                                                </button>
                                                <button type="button" onclick="removeFromWishlistPage('${prod.id}')" class="btn btn-outline btn-sm" style="color: var(--clr-danger); border-color: var(--clr-border);">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                `;
                            }).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        }

        function moveToCart(productId) {
            handleAddToCart(productId, 1);
            db.toggleWishlist(productId);
            renderWishlist();
            updateBadges();
        }

        function removeFromWishlistPage(productId) {
            db.toggleWishlist(productId);
            renderWishlist();
            updateBadges();
            showToast('Item removed from Wishlist', 'info');
        }
    </script>
</asp:Content>
