<%@ Page Title="FurniShop - Shopping Bag" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="FurniShop.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Your Luxury Shopping Bag</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Cart</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="display: grid; grid-template-columns: 1fr 340px; gap: 3rem;">
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                        <h3>Cart Items</h3>
                        <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" OnClick="btnClearCart_Click" CssClass="btn btn-outline btn-sm" ForeColor="Red" />
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table" DataKeyNames="cart_id" OnRowDeleting="GridView1_RowDeleting" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="Product">
                                    <ItemTemplate>
                                        <div style="display: flex; align-items: center; gap: 1rem;">
                                            <asp:Image ID="imgProd" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="70px" Height="55px" style="object-fit: cover; border-radius: 4px;" />
                                            <div>
                                                <a href='ProductDetails.aspx?pid=<%# Eval("cart_prod_id") %>' style="font-weight: 700; color: var(--clr-text-main);">
                                                    <%# Eval("ProductName") %>
                                                </a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Price">
                                    <ItemTemplate>
                                        &#8377;<%# Eval("Price") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <%# Eval("qunty") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Total">
                                    <ItemTemplate>
                                        <strong>&#8377;<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("qunty")) %></strong>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Remove" CssClass="btn btn-outline btn-sm" ForeColor="Red" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div style="text-align: center; padding: 3rem;">
                                    <h3>Your Cart is Empty</h3>
                                    <p style="color: var(--clr-text-muted); margin-bottom: 1rem;">Browse our collection and add furniture pieces.</p>
                                    <a href="Shop.aspx" class="btn btn-primary">Go to Shop</a>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Order Summary Sidebar -->
                <div>
                    <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border);">
                        <h3 style="font-size: 1.3rem; margin-bottom: 1.5rem; padding-bottom: 0.75rem; border-bottom: 1px solid var(--clr-border);">Order Summary</h3>
                        
                        <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; font-size: 1.1rem;">
                            <span>Grand Total:</span>
                            <asp:Label ID="lblGrandTotal" runat="server" Font-Bold="true" style="color: var(--clr-accent);" Text="&#8377;0.00"></asp:Label>
                        </div>

                        <a href="Checkout.aspx" class="btn btn-primary btn-lg" style="width: 100%; text-align: center; display: block; margin-top: 1.5rem;">
                            Proceed to Checkout
                        </a>
                        <a href="Shop.aspx" class="btn btn-outline btn-sm" style="width: 100%; text-align: center; display: block; margin-top: 0.75rem;">
                            Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
