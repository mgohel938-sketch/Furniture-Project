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
    public partial class AdminDashboard : System.Web.UI.Page
    {
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
                loadDashboardStats();
                loadRecentOrders();
            }
        }

        void loadDashboardStats()
        {
            getcon();

            cmd = new SqlCommand("select count(*) from Products", con);
            lblTotalProducts.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from Users", con);
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from Orders", con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select isnull(sum(TotalPrice), 0) from Orders", con);
            object rev = cmd.ExecuteScalar();
            decimal totalRev = rev != null ? Convert.ToDecimal(rev) : 0;
            lblTotalSales.Text = totalRev.ToString("0.00");
        }

        void loadRecentOrders()
        {
            getcon();
            da = new SqlDataAdapter("select top 5 * from Orders order by OrderId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewRecentOrders.DataSource = ds;
            GridViewRecentOrders.DataBind();
        }
    }
}
