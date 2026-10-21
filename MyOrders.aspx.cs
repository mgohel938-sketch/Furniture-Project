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
    public partial class MyOrders : System.Web.UI.Page
    {
        protected GridView GridViewMyOrders;

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
                fetchMyOrders();
            }
        }

        void fetchMyOrders()
        {
            getcon();
            string user = Session["user"] != null ? Session["user"].ToString() : "";
            string q = "select * from Orders order by OrderId desc";
            if (!string.IsNullOrEmpty(user))
            {
                q = "select * from Orders where CustomerEmail='" + user + "' order by OrderId desc";
            }

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewMyOrders.DataSource = ds;
            GridViewMyOrders.DataBind();
        }
    }
}
