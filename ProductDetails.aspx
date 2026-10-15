<%@ Page Title="FurniShop - Product Details" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="FurniShop.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="container" style="padding: 4rem 0 6rem;">
            <div id="product-detail-wrap">
            </div>

            <!-- Customer Reviews Section -->
            <section style="margin-top: 5rem; border-top: 1px solid var(--clr-border); padding-top: 4rem;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem;">
                    
                    <!-- Approved Reviews List -->
                    <div>
                        <h3 style="font-size: 1.5rem; margin-bottom: 1.5rem;">Customer Reviews (<span id="reviews-count">0</span>)</h3>
                        <div id="reviews-list-container" style="display: flex; flex-direction: column; gap: 1.5rem;">
                        </div>
                    </div>

                    <!-- Add Review Form -->
                    <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); height: fit-content;">
                        <h3 style="font-size: 1.25rem; margin-bottom: 1.25rem;">Write a Luxury Review</h3>
                        <div id="add-review-form">
                            <div class="form-group">
                                <label class="form-label">Your Name</label>
                                <input type="text" id="rev-name" class="form-control" required placeholder="e.g. Harrison Vance">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Rating</label>
                                <select id="rev-rating" class="form-control">
                                    <option value="5">5 Stars - Exceptional</option>
                                    <option value="4">4 Stars - Excellent</option>
                                    <option value="3">3 Stars - Good</option>
                                    <option value="2">2 Stars - Average</option>
                                    <option value="1">1 Star - Unsatisfactory</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Review Comment</label>
                                <textarea id="rev-comment" class="form-control" rows="4" required placeholder="Share your experience regarding material quality, comfort, and delivery..."></textarea>
                            </div>
                            <button type="button" onclick="handleReviewSubmit()" class="btn btn-primary" style="width: 100%;">Submit Review</button>
                        </div>
                    </div>

                </div>
            </section>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        let currentProductId = null;

        document.addEventListener('DOMContentLoaded', () => {
            const urlParams = new URLSearchParams(window.location.search);
            currentProductId = urlParams.get('id') || 'prod-101';
            
            renderProductDetails();
            renderProductReviews();
        });

        function renderProductDetails() {
            const product = db.getProductById(currentProductId);
            const container = document.getElementById('product-detail-wrap');
            if (!container) return;

            if (!product) {
                container.innerHTML = `
                    <div style="text-align:center; padding: 5rem 0;">
                        <h2>Product Not Found</h2>
                        <a href="Shop.aspx" class="btn btn-primary" style="margin-top:1rem;">Back to Shop</a>
                    </div>
                `;
                return;
            }

            document.title = `FurniShop - ${product.name}`;
            const finalPrice = product.discount ? product.price * (1 - product.discount/100) : product.price;
            const isWish = db.isInWishlist(product.id);

            container.innerHTML = `
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: start;">
                    <div>
                        <div style="aspect-ratio: 4/3; border-radius: var(--radius-md); overflow: hidden; background: var(--clr-bg-alt); border: 1px solid var(--clr-border);">
                            <img src="${product.image}" id="main-product-img" alt="${product.name}" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                    </div>

                    <div>
                        <div class="product-category">${product.category}</div>
                        <h1 style="font-size: 2.5rem; margin: 0.5rem 0 1rem;">${product.name}</h1>
                        
                        <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem;">
                            <div class="product-rating" style="font-size: 1.1rem;">
                                ${'<i class="fa-solid fa-star"></i>'.repeat(Math.floor(product.rating))}
                                <span style="color: var(--clr-text-main); font-weight: 700; margin-left: 0.4rem;">${product.rating}</span>
                                <span class="rating-count">(${product.reviewCount} customer reviews)</span>
                            </div>
                            <span style="color: var(--clr-border);">|</span>
                            <span style="font-weight: 600; color: ${product.stock > 0 ? 'var(--clr-success)' : 'var(--clr-danger)'}">
                                ${product.stock > 0 ? `<i class="fa-solid fa-circle-check"></i> In Stock (${product.stock} available)` : '<i class="fa-solid fa-circle-xmark"></i> Out of Stock'}
                            </span>
                        </div>

                        <div style="display: flex; align-items: baseline; gap: 1rem; margin-bottom: 2rem;">
                            <span style="font-size: 2.25rem; font-weight: 800; color: var(--clr-text-main);">${formatPrice(finalPrice)}</span>
                            ${product.discount ? `<span style="font-size: 1.25rem; color: var(--clr-text-light); text-decoration: line-through;">${formatPrice(product.price)}</span>` : ''}
                            ${product.discount ? `<span class="badge badge-discount" style="font-size:0.85rem;">Save ${product.discount}%</span>` : ''}
                        </div>

                        <p style="color: var(--clr-text-muted); font-size: 1.05rem; margin-bottom: 2rem; line-height: 1.8;">
                            ${product.description}
                        </p>

                        <div style="background: var(--clr-bg-alt); padding: 1.25rem; border-radius: var(--radius-sm); margin-bottom: 2rem; display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; font-size: 0.9rem;">
                            <div><strong>Material:</strong> ${product.material || 'Solid Wood & Leather'}</div>
                            <div><strong>Dimensions:</strong> ${product.dimensions || 'Standard Luxury Spec'}</div>
                            <div><strong>Color Option:</strong> ${product.color || 'Signature Tone'}</div>
                            <div><strong>Craftsmanship:</strong> Italian Artisanal Hand-Finish</div>
                        </div>

                        <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 2rem;">
                            <div style="display: flex; align-items: center; border: 1px solid var(--clr-border); border-radius: var(--radius-sm);">
                                <button type="button" onclick="changeQty(-1)" style="padding: 0.75rem 1rem; font-weight:700;">-</button>
                                <input type="number" id="detail-qty" value="1" min="1" max="${product.stock}" style="width: 50px; text-align: center; border: none; font-weight:700;">
                                <button type="button" onclick="changeQty(1)" style="padding: 0.75rem 1rem; font-weight:700;">+</button>
                            </div>
                            
                            <button type="button" onclick="addCurrentToCart()" class="btn btn-primary" ${product.stock <= 0 ? 'disabled style="opacity:0.5;"' : ''}>
                                <i class="fa-solid fa-bag-shopping"></i> Add to Cart
                            </button>
                            
                            <button type="button" onclick="buyNowCurrent()" class="btn btn-accent" ${product.stock <= 0 ? 'disabled style="opacity:0.5;"' : ''}>
                                Buy Now
                            </button>
                            
                            <button type="button" onclick="handleToggleWishlist('${product.id}', this)" class="wishlist-btn-card ${isWish ? 'active' : ''}" style="position:relative; top:auto; right:auto; width:48px; height:48px; border: 1px solid var(--clr-border);">
                                <i class="fa-solid fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
        }

        function changeQty(delta) {
            const input = document.getElementById('detail-qty');
            let val = parseInt(input.value) + delta;
            if (val < 1) val = 1;
            input.value = val;
        }

        function addCurrentToCart() {
            const qty = parseInt(document.getElementById('detail-qty').value);
            handleAddToCart(currentProductId, qty);
        }

        function buyNowCurrent() {
            const qty = parseInt(document.getElementById('detail-qty').value);
            db.addToCart(currentProductId, qty);
            window.location.href = 'Checkout.aspx';
        }

        function renderProductReviews() {
            const reviews = db.getReviews().filter(r => r.productId === currentProductId && r.status === 'Approved');
            document.getElementById('reviews-count').textContent = reviews.length;
            const container = document.getElementById('reviews-list-container');
            if (!container) return;

            if (reviews.length === 0) {
                container.innerHTML = `<p style="color: var(--clr-text-muted);">No reviews approved for this item yet. Be the first to share your experience!</p>`;
                return;
            }

            container.innerHTML = reviews.map(rev => `
                <div style="background: var(--clr-bg-card); padding: 1.5rem; border-radius: var(--radius-sm); border: 1px solid var(--clr-border);">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 0.5rem;">
                        <span style="font-weight: 700;">${rev.customerName}</span>
                        <span style="font-size: 0.8rem; color: var(--clr-text-light);">${rev.date}</span>
                    </div>
                    <div style="color: #eab308; margin-bottom: 0.5rem;">
                        ${'<i class="fa-solid fa-star"></i>'.repeat(rev.rating)}
                    </div>
                    <p style="color: var(--clr-text-muted); font-size: 0.95rem;">${rev.comment}</p>
                </div>
            `).join('');
        }

        function handleReviewSubmit() {
            const name = document.getElementById('rev-name').value;
            const rating = document.getElementById('rev-rating').value;
            const comment = document.getElementById('rev-comment').value;

            if (!name || !comment) {
                showToast('Please fill out your name and review comment', 'error');
                return;
            }

            db.addReview({
                productId: currentProductId,
                customerName: name,
                rating: rating,
                comment: comment
            });

            showToast('Thank you! Your review has been submitted for moderation.', 'success');
            document.getElementById('rev-name').value = '';
            document.getElementById('rev-comment').value = '';
            renderProductReviews();
        }
    </script>
</asp:Content>
