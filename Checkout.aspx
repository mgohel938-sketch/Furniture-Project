<%@ Page Title="FurniShop - Secure Checkout" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="FurniShop.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Order Checkout</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <a href="Cart.aspx">Cart</a> / <span>Checkout</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="display: grid; grid-template-columns: 1fr 380px; gap: 3.5rem;">
                <div>
                    <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); margin-bottom: 2rem;">
                        <h3 style="font-size: 1.35rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--clr-border);">
                            <i class="fa-solid fa-truck"></i> Delivery Information
                        </h3>

                        <div style="margin-bottom: 1rem;">
                            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                            <div class="form-group">
                                <label class="form-label">Full Name *</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Milan Patel" required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email Address *</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="milan@example.com" required="required"></asp:TextBox>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                            <div class="form-group">
                                <label class="form-label">Phone Number *</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91 9876543210" required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Payment Method *</label>
                                <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Cash On Delivery (COD)" Value="Cash On Delivery"></asp:ListItem>
                                    <asp:ListItem Text="Credit / Debit Card" Value="Credit / Debit Card"></asp:ListItem>
                                    <asp:ListItem Text="UPI / Online Transfer" Value="UPI / Online Transfer"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Delivery Address *</label>
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Full delivery address, Landmark, City, Pincode" required="required"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Order Total Sidebar -->
                <div>
                    <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border);">
                        <h3 style="font-size: 1.3rem; margin-bottom: 1.5rem; padding-bottom: 0.75rem; border-bottom: 1px solid var(--clr-border);">Order Summary</h3>

                        <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; font-size: 1.2rem;">
                            <span>Total Amount:</span>
                            <asp:Label ID="lblOrderTotal" runat="server" Font-Bold="true" style="color: var(--clr-accent);" Text="&#8377;0.00"></asp:Label>
                        </div>

                        <asp:Button ID="btnPlaceOrder" runat="server" Text="Confirm & Place Order" OnClick="btnPlaceOrder_Click" CssClass="btn btn-primary btn-lg" style="width: 100%; margin-top: 1.5rem;" />
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
