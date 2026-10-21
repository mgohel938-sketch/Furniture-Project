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
            <div class="table-responsive">
                <asp:GridView ID="GridViewMyOrders" runat="server" AutoGenerateColumns="False" CssClass="table" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                        <asp:BoundField DataField="Address" HeaderText="Delivery Address" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total (Rs.)" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd-MM-yyyy}" />
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 4rem 1rem;">
                            <i class="fa-solid fa-box-open" style="font-size: 4rem; color: var(--clr-text-light); margin-bottom: 1.5rem;"></i>
                            <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">No Past Orders Found</h2>
                            <p style="color: var(--clr-text-muted); margin-bottom: 2rem;">You haven't placed any orders yet.</p>
                            <a href="Shop.aspx" class="btn btn-primary btn-lg">Explore Shop Collection</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
