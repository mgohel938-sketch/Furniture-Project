using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace FurniShop
{
    public partial class AdminProducts : System.Web.UI.Page
    {
        protected TextBox txtSearch;
        protected Button btnSearch;
        protected DropDownList ddlCategory;
        protected GridView GridViewProducts;

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gridfill();
            }
        }

        void gridfill()
        {
            getcon();
            string q = "select * from Products";
            if (ddlCategory.SelectedValue != "All")
            {
                q += " where Category='" + ddlCategory.SelectedValue + "'";
            }
            q += " order by Id desc";

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewProducts.DataSource = ds;
            GridViewProducts.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select * from Products where ProductName like '%" + txtSearch.Text + "%' order by Id desc";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewProducts.DataSource = ds;
            GridViewProducts.DataBind();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            gridfill();
        }

        protected void GridViewProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("delete from Products where Id='" + id + "'", con);
            cmd.ExecuteNonQuery();
            gridfill();
        }
    }
}
