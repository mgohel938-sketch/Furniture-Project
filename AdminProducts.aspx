<%@ Page Title="Products Management - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="FurniShop.AdminProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Furniture Catalog Management</h2>
            <a href="AdminAddProduct.aspx" class="btn btn-accent btn-sm">
                <i class="fa-solid fa-plus"></i> Add New Product
            </a>
        </div>

        <div style="padding: 1.25rem 1.75rem; background: #fafafa; border-bottom: 1px solid var(--admin-border); display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
            <div style="flex-grow: 1; max-width: 350px; display: flex; gap: 0.5rem;">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search product name..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-accent btn-sm" />
            </div>
            <div>
                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="form-control">
                    <asp:ListItem Text="All Categories" Value="All"></asp:ListItem>
                    <asp:ListItem Text="Sofa" Value="Sofa"></asp:ListItem>
                    <asp:ListItem Text="Bed" Value="Bed"></asp:ListItem>
                    <asp:ListItem Text="Chair" Value="Chair"></asp:ListItem>
                    <asp:ListItem Text="Table" Value="Table"></asp:ListItem>
                    <asp:ListItem Text="Dining" Value="Dining"></asp:ListItem>
                    <asp:ListItem Text="Wardrobe" Value="Wardrobe"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="admin-card-body" style="padding: 0;">
            <div class="table-responsive">
                <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="False" CssClass="table" DataKeyNames="Id" OnRowDeleting="GridViewProducts_RowDeleting" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="60px" Height="45px" style="object-fit:cover; border-radius:4px;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Category" HeaderText="Category" />
                        <asp:BoundField DataField="Price" HeaderText="Price (Rs.)" />
                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <a href='AdminEditProduct.aspx?id=<%# Eval("Id") %>' class="btn btn-outline btn-sm">Edit</a>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-outline btn-sm" ForeColor="Red" OnClientClick="return confirm('Are you sure you want to delete this product?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 2.5rem;">No products found in catalog.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
