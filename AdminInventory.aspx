<%@ Page Title="Inventory - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminInventory.aspx.cs" Inherits="FurniShop.AdminInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Inventory Stock Management</h2>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <asp:GridView ID="GridViewInventory" runat="server" AutoGenerateColumns="False" CssClass="table" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Product ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Category" HeaderText="Category" />
                        <asp:BoundField DataField="Price" HeaderText="Price (Rs.)" />
                        <asp:BoundField DataField="Stock" HeaderText="Stock Quantity" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <a href='AdminEditProduct.aspx?id=<%# Eval("Id") %>' class="btn btn-outline btn-sm">Update Stock</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 2rem;">No items found.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
