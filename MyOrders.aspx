<%@ Page Title="FurniShop - My Orders" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="FurniShop.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">My Orders & Purchases</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>My Orders</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div id="my-orders-container">
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderMyOrders();
        });

        function renderMyOrders() {
            const currentUser = db.getCurrentUser();
            const allOrders = db.getOrders();
            const container = document.getElementById('my-orders-container');
            if (!container) return;

            let customerOrders = currentUser 
                ? allOrders.filter(o => o.customerId === currentUser.id || o.customerEmail === currentUser.email)
                : allOrders;

            if (customerOrders.length === 0) {
                container.innerHTML = `
                    <div style="text-align: center; padding: 4rem 1rem;">
                        <i class="fa-solid fa-box-open" style="font-size: 4rem; color: var(--clr-text-light); margin-bottom: 1.5rem;"></i>
                        <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">No Past Orders Found</h2>
                        <p style="color: var(--clr-text-muted); margin-bottom: 2rem;">You haven't placed any luxury furniture orders yet.</p>
                        <a href="Shop.aspx" class="btn btn-primary btn-lg">Explore Shop Collection</a>
                    </div>
                `;
                return;
            }

            container.innerHTML = `
                <div style="display: flex; flex-direction: column; gap: 2rem;">
                    ${customerOrders.map(order => {
                        let statusColor = '#e65100';
                        if (order.orderStatus === 'Confirmed') statusColor = '#0d47a1';
                        if (order.orderStatus === 'Processing') statusColor = '#4a148c';
                        if (order.orderStatus === 'Shipped') statusColor = '#004d40';
                        if (order.orderStatus === 'Delivered') statusColor = '#1b5e20';
                        if (order.orderStatus === 'Cancelled') statusColor = '#b71c1c';

                        return `
                            <div style="background: var(--clr-bg-card); border-radius: var(--radius-md); border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm); overflow: hidden;">
                                <div style="background: var(--clr-bg-alt); padding: 1.25rem 1.75rem; border-bottom: 1px solid var(--clr-border); display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 1rem;">
                                    <div>
                                        <div style="font-size: 0.75rem; color: var(--clr-text-muted); text-transform: uppercase; font-weight:700;">Order ID</div>
                                        <div style="font-weight: 800; font-size: 1.1rem; color: var(--clr-accent);">${order.id}</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 0.75rem; color: var(--clr-text-muted); text-transform: uppercase; font-weight:700;">Date</div>
                                        <div style="font-weight: 600;">${order.date}</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 0.75rem; color: var(--clr-text-muted); text-transform: uppercase; font-weight:700;">Total Amount</div>
                                        <div style="font-weight: 700; color: var(--clr-text-main);">${formatPrice(order.total)}</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 0.75rem; color: var(--clr-text-muted); text-transform: uppercase; font-weight:700;">Live Status</div>
                                        <div style="font-weight: 700; color: ${statusColor}; text-transform: uppercase; font-size: 0.85rem;">
                                            <i class="fa-solid fa-circle" style="font-size:0.6rem; vertical-align:middle; margin-right:4px;"></i> ${order.orderStatus}
                                        </div>
                                    </div>
                                </div>

                                <div style="padding: 1.75rem;">
                                    <div style="display: flex; flex-direction: column; gap: 1rem; margin-bottom: 1.5rem;">
                                        ${order.items.map(item => `
                                            <div style="display: flex; align-items: center; gap: 1.25rem;">
                                                <img src="${item.image}" alt="${item.name}" style="width: 70px; height: 55px; border-radius: var(--radius-sm); object-fit: cover;">
                                                <div style="flex-grow: 1;">
                                                    <div style="font-weight: 700;">${item.name}</div>
                                                    <div style="font-size: 0.85rem; color: var(--clr-text-muted);">Quantity: ${item.quantity} x ${formatPrice(item.price)}</div>
                                                </div>
                                                <div style="font-weight: 700;">${formatPrice(item.price * item.quantity)}</div>
                                            </div>
                                        `).join('')}
                                    </div>

                                    <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--clr-border); padding-top: 1rem; font-size: 0.9rem;">
                                        <div style="color: var(--clr-text-muted);">
                                            Payment: <strong>${order.paymentMethod}</strong> (${order.paymentStatus})
                                        </div>
                                        <div>
                                            <a href="OrderConfirmation.aspx?id=${order.id}" class="btn btn-outline btn-sm">View Receipt</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                    }).join('')}
                </div>
            `;
        }
    </script>
</asp:Content>
