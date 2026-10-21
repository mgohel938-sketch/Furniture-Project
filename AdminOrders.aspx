<%@ Page Title="Orders - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="FurniShop.AdminOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Customer Orders Management</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="table" DataKeyNames="OrderId" OnRowDeleting="GridViewOrders_RowDeleting" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="CustomerEmail" HeaderText="Email" />
                        <asp:BoundField DataField="Address" HeaderText="Delivery Address" />
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total Amount (Rs.)" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-outline btn-sm" ForeColor="Red" OnClientClick="return confirm('Delete this order?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 3rem;">No customer orders placed yet.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
