<%@ Page Title="FurniShop - Order Confirmed" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="FurniShop.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="container" style="padding: 4rem 0 6rem; max-width: 800px;">
            <div style="background: var(--clr-bg-card); padding: 3rem; border-radius: var(--radius-lg); border: 1px solid var(--clr-border); box-shadow: var(--shadow-md); text-align: center;">
                <div style="width: 80px; height: 80px; border-radius: 50%; background: rgba(46, 125, 50, 0.1); color: var(--clr-success); display: flex; align-items: center; justify-content: center; font-size: 2.5rem; margin: 0 auto 1.5rem;">
                    <i class="fa-solid fa-circle-check"></i>
                </div>

                <h1 style="font-size: 2.25rem; margin-bottom: 0.5rem;">Thank You! Your Order Has Been Placed</h1>
                <p style="color: var(--clr-text-muted); font-size: 1.05rem; margin-bottom: 2rem;">
                    We are processing your order and preparing your furniture.
                </p>

                <div style="background: var(--clr-bg-alt); padding: 2rem; border-radius: var(--radius-md); text-align: left; margin-bottom: 2.5rem; border: 1px solid var(--clr-border);">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1rem;">
                        <div>
                            <div style="font-size: 0.85rem; color: var(--clr-text-muted); font-weight: 700;">Order ID:</div>
                            <div style="font-size: 1.2rem; font-weight: 800; color: var(--clr-accent);">
                                #<asp:Label ID="lblOrderId" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--clr-text-muted); font-weight: 700;">Order Date:</div>
                            <div style="font-size: 1.1rem; font-weight: 700;">
                                <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                        <div>
                            <div style="font-size: 0.85rem; color: var(--clr-text-muted); font-weight: 700;">Customer Name:</div>
                            <div style="font-size: 1.1rem; font-weight: 600;">
                                <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--clr-text-muted); font-weight: 700;">Total Amount:</div>
                            <div style="font-size: 1.2rem; font-weight: 800; color: var(--clr-success);">
                                &#8377;<asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="display: flex; gap: 1rem; justify-content: center;">
                    <a href="Shop.aspx" class="btn btn-primary btn-lg">Continue Shopping</a>
                    <a href="MyOrders.aspx" class="btn btn-outline btn-lg">View My Orders</a>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
