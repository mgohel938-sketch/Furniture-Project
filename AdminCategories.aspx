<%@ Page Title="Categories - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategories.aspx.cs" Inherits="FurniShop.AdminCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Furniture Categories Directory</h2>
            <a href="AdminAddProduct.aspx" class="btn btn-accent btn-sm">
                <i class="fa-solid fa-plus"></i> Add Product Under Category
            </a>
        </div>
        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False" CssClass="table" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Category" HeaderText="Category Name" />
                        <asp:BoundField DataField="ProdCount" HeaderText="Total Products" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <a href='AdminProducts.aspx' class="btn btn-outline btn-sm">View Products</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 2rem;">No categories found.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
