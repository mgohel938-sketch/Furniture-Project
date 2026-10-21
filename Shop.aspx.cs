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
    public partial class Shop : System.Web.UI.Page
    {
        protected Label lblTitle;
        protected TextBox txtSearch;
        protected Button btnSearch;
        protected Repeater rptrProducts;

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
                if (Request.QueryString["category"] != null)
                {
                    string cat = Request.QueryString["category"].ToString();
                    lblTitle.Text = cat + " Collections";
                    fetchCategoryProducts(cat);
                }
                else
                {
                    lblTitle.Text = "All Products";
                    fetchAllProducts();
                }
            }
        }

        void fetchAllProducts()
        {
            getcon();
            da = new SqlDataAdapter("select * from Products order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptrProducts.DataSource = ds;
            rptrProducts.DataBind();
        }

        void fetchCategoryProducts(string cat)
        {
            getcon();
            da = new SqlDataAdapter("select * from Products where Category='" + cat + "' order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptrProducts.DataSource = ds;
            rptrProducts.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                getcon();
                da = new SqlDataAdapter("select * from Products where ProductName like '%" + txtSearch.Text + "%' or Category like '%" + txtSearch.Text + "%'", con);
                ds = new DataSet();
                da.Fill(ds);
                lblTitle.Text = "Search Results for '" + txtSearch.Text + "'";
                rptrProducts.DataSource = ds;
                rptrProducts.DataBind();
            }
            else
            {
                fetchAllProducts();
            }
        }
    }
}
