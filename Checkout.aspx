<%@ Page Title="FurniShop - Secure Checkout" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="FurniShop.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">White-Glove Order Checkout</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <a href="Cart.aspx">Cart</a> / <span>Checkout</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div id="checkout-content">
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderCheckoutPage();
        });

        function renderCheckoutPage() {
            const cart = db.getCart();
            const container = document.getElementById('checkout-content');
            if (!container) return;

            if (cart.length === 0) {
                container.innerHTML = `
                    <div style="text-align: center; padding: 4rem 1rem;">
                        <h2>Your Shopping Cart is Empty</h2>
                        <p style="color: var(--clr-text-muted); margin-bottom: 1.5rem;">Add items to your cart before proceeding to checkout.</p>
                        <a href="Shop.aspx" class="btn btn-primary">Return to Shop</a>
                    </div>
                `;
                return;
            }

            const currentUser = db.getCurrentUser() || {};
            const settings = db.getSettings();

            let subtotal = 0;
            cart.forEach(item => subtotal += item.price * item.quantity);
            const tax = (subtotal * settings.taxRate) / 100;
            const delivery = settings.deliveryCharge;
            const total = subtotal + tax + delivery;

            container.innerHTML = `
                <div id="checkout-form" style="display: grid; grid-template-columns: 1fr 420px; gap: 3.5rem;">
                    <div>
                        <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); margin-bottom: 2rem;">
                            <h3 style="font-size: 1.35rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--clr-border);">
                                <i class="fa-solid fa-truck"></i> 1. Delivery & Address Information
                            </h3>

                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">Full Name *</label>
                                    <input type="text" id="cust-name" class="form-control" required value="${currentUser.name || ''}" placeholder="e.g. Eleanor Vance">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email Address *</label>
                                    <input type="email" id="cust-email" class="form-control" required value="${currentUser.email || ''}" placeholder="eleanor@example.com">
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">Phone Number *</label>
                                    <input type="tel" id="cust-phone" class="form-control" required value="${currentUser.phone || ''}" placeholder="+1 (555) 0182">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Street Address *</label>
                                    <input type="text" id="cust-address" class="form-control" required value="${currentUser.address || ''}" placeholder="742 Evergreen Terrace, Suite 4B">
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">City *</label>
                                    <input type="text" id="cust-city" class="form-control" required value="${currentUser.city || ''}" placeholder="New York">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">State *</label>
                                    <input type="text" id="cust-state" class="form-control" required value="${currentUser.state || ''}" placeholder="NY">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Zip / Pincode *</label>
                                    <input type="text" id="cust-pincode" class="form-control" required value="${currentUser.pincode || ''}" placeholder="10001">
                                </div>
                            </div>
                        </div>

                        <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border);">
                            <h3 style="font-size: 1.35rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--clr-border);">
                                <i class="fa-solid fa-credit-card"></i> 2. Payment Method
                            </h3>

                            <div style="display: flex; flex-direction: column; gap: 1rem; margin-bottom: 1.5rem;">
                                <label style="display: flex; align-items: center; gap: 1rem; padding: 1rem; border: 1px solid var(--clr-border); border-radius: var(--radius-sm); cursor: pointer;">
                                    <input type="radio" name="paymentMethod" value="Credit Card" checked onchange="togglePaymentInputs('card')">
                                    <div>
                                        <div style="font-weight: 700;"><i class="fa-solid fa-credit-card"></i> Credit / Debit Card</div>
                                        <div style="font-size: 0.8rem; color: var(--clr-text-muted);">Visa, MasterCard, American Express</div>
                                    </div>
                                </label>

                                <label style="display: flex; align-items: center; gap: 1rem; padding: 1rem; border: 1px solid var(--clr-border); border-radius: var(--radius-sm); cursor: pointer;">
                                    <input type="radio" name="paymentMethod" value="UPI / Instant Pay" onchange="togglePaymentInputs('upi')">
                                    <div>
                                        <div style="font-weight: 700;"><i class="fa-solid fa-qrcode"></i> Instant UPI / Apple Pay</div>
                                        <div style="font-size: 0.8rem; color: var(--clr-text-muted);">Instant mobile transfer</div>
                                    </div>
                                </label>

                                <label style="display: flex; align-items: center; gap: 1rem; padding: 1rem; border: 1px solid var(--clr-border); border-radius: var(--radius-sm); cursor: pointer;">
                                    <input type="radio" name="paymentMethod" value="Cash on Delivery" onchange="togglePaymentInputs('cod')">
                                    <div>
                                        <div style="font-weight: 700;"><i class="fa-solid fa-hand-holding-dollar"></i> Cash on Delivery (COD)</div>
                                        <div style="font-size: 0.8rem; color: var(--clr-text-muted);">Pay upon white-glove inspection at home</div>
                                    </div>
                                </label>
                            </div>

                            <div id="card-fields" style="background: var(--clr-bg-alt); padding: 1.25rem; border-radius: var(--radius-sm); display: block;">
                                <div class="form-group">
                                    <label class="form-label">Cardholder Name</label>
                                    <input type="text" class="form-control" placeholder="Name on card">
                                </div>
                                <div style="display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 1rem;">
                                    <div class="form-group">
                                        <label class="form-label">Card Number</label>
                                        <input type="text" class="form-control" placeholder="4000 1234 5678 9010">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Exp Date</label>
                                        <input type="text" class="form-control" placeholder="MM/YY">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">CVV</label>
                                        <input type="text" class="form-control" placeholder="123">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); position: sticky; top: 100px;">
                            <h3 style="font-size: 1.35rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--clr-border);">Order Summary</h3>
                            
                            <div style="display: flex; flex-direction: column; gap: 1rem; max-height: 240px; overflow-y: auto; margin-bottom: 1.5rem; padding-right: 0.5rem;">
                                ${cart.map(item => `
                                    <div style="display: flex; gap: 1rem; align-items: center;">
                                        <img src="${item.image}" alt="${item.name}" style="width: 50px; height: 40px; border-radius: 4px; object-fit: cover;">
                                        <div style="flex-grow: 1;">
                                            <div style="font-weight: 700; font-size: 0.85rem;">${item.name}</div>
                                            <div style="font-size: 0.75rem; color: var(--clr-text-muted);">Qty: ${item.quantity} x ${formatPrice(item.price)}</div>
                                        </div>
                                        <div style="font-weight: 700; font-size: 0.9rem;">${formatPrice(item.price * item.quantity)}</div>
                                    </div>
                                `).join('')}
                            </div>

                            <div style="display: flex; flex-direction: column; gap: 0.75rem; font-size: 0.9rem; border-top: 1px solid var(--clr-border); padding-top: 1rem; margin-bottom: 1.5rem;">
                                <div style="display: flex; justify-content: space-between;">
                                    <span>Subtotal:</span>
                                    <span style="font-weight: 700;">${formatPrice(subtotal)}</span>
                                </div>
                                <div style="display: flex; justify-content: space-between;">
                                    <span>Tax (${settings.taxRate}%):</span>
                                    <span style="font-weight: 700;">${formatPrice(tax)}</span>
                                </div>
                                <div style="display: flex; justify-content: space-between;">
                                    <span>White-Glove Delivery:</span>
                                    <span style="font-weight: 700;">${formatPrice(delivery)}</span>
                                </div>
                                <div style="display: flex; justify-content: space-between; font-size: 1.25rem; font-weight: 800; border-top: 2px solid var(--clr-border); padding-top: 1rem; color: var(--clr-text-main);">
                                    <span>Total Amount:</span>
                                    <span style="color: var(--clr-accent);">${formatPrice(total)}</span>
                                </div>
                            </div>

                            <button type="button" onclick="handlePlaceOrder()" class="btn btn-accent btn-lg" style="width: 100%;">
                                Place Order Now <i class="fa-solid fa-lock"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
        }

        function togglePaymentInputs(type) {
            const cardFields = document.getElementById('card-fields');
            if (!cardFields) return;
            if (type === 'card') cardFields.style.display = 'block';
            else cardFields.style.display = 'none';
        }

        function handlePlaceOrder() {
            const cart = db.getCart();
            if (cart.length === 0) return;

            const name = document.getElementById('cust-name').value;
            const email = document.getElementById('cust-email').value;
            const phone = document.getElementById('cust-phone').value;
            const address = document.getElementById('cust-address').value;
            const city = document.getElementById('cust-city').value;
            const state = document.getElementById('cust-state').value;
            const pincode = document.getElementById('cust-pincode').value;

            if (!name || !email || !phone || !address || !city || !state || !pincode) {
                showToast('Please fill in all required shipping address fields', 'error');
                return;
            }

            const currentUser = db.getCurrentUser();
            const settings = db.getSettings();

            let subtotal = 0;
            const items = cart.map(item => {
                subtotal += item.price * item.quantity;
                return {
                    productId: item.productId,
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                    image: item.image
                };
            });

            const tax = (subtotal * settings.taxRate) / 100;
            const delivery = settings.deliveryCharge;
            const total = subtotal + tax + delivery;

            const selectedPayment = document.querySelector('input[name="paymentMethod"]:checked').value;

            const orderData = {
                customerId: currentUser ? currentUser.id : null,
                name: name,
                email: email,
                phone: phone,
                address: address,
                city: city,
                state: state,
                pincode: pincode,
                items: items,
                subtotal: subtotal,
                tax: tax,
                delivery: delivery,
                total: total,
                paymentMethod: selectedPayment
            };

            const createdOrder = db.createOrder(orderData);
            updateBadges();

            // Save order into SQL Server Database (dbo.Orders)
            fetch('Checkout.aspx/SaveOrderToDB', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({
                    customerName: name,
                    customerEmail: email,
                    address: `${address}, ${city}, ${state} ${pincode}`,
                    totalPrice: total,
                    paymentMethod: selectedPayment
                })
            });

            showToast('Order placed successfully!', 'success');
            setTimeout(() => {
                window.location.href = `OrderConfirmation.aspx?id=${createdOrder.id}`;
            }, 800);
        }
    </script>
</asp:Content>
