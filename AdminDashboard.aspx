<%@ Page Title="Dashboard - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="FurniShop.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <!-- Live Metrics Stat Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-info">
                <h3>Total Products</h3>
                <div class="stat-number"><asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="stat-icon"><i class="fa-solid fa-couch"></i></div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>Total Customers</h3>
                <div class="stat-number"><asp:Label ID="lblTotalCustomers" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="stat-icon success"><i class="fa-solid fa-users"></i></div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>Total Orders</h3>
                <div class="stat-number"><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></div>
            </div>
            <div class="stat-icon"><i class="fa-solid fa-receipt"></i></div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>Total Sales Revenue</h3>
                <div class="stat-number" style="font-size: 1.5rem;">&#8377;<asp:Label ID="lblTotalSales" runat="server" Text="0.00"></asp:Label></div>
            </div>
            <div class="stat-icon success"><i class="fa-solid fa-indian-rupee-sign"></i></div>
        </div>
    </div>

    <!-- Recent Orders -->
    <div class="admin-card" style="margin-top: 2rem;">
        <div class="admin-card-header">
            <h2>Recent Customer Orders</h2>
            <a href="AdminOrders.aspx" class="btn btn-outline btn-sm">View All Orders</a>
        </div>
        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <asp:GridView ID="GridViewRecentOrders" runat="server" AutoGenerateColumns="False" CssClass="table" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="CustomerEmail" HeaderText="Email" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total (Rs.)" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 2rem;">No orders placed yet.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
