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
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected Label lblOrderId;
        protected Label lblOrderDate;
        protected Label lblCustomerName;
        protected Label lblTotalPrice;

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
                fetchLatestOrder();
            }
        }

        void fetchLatestOrder()
        {
            getcon();
            string user = Session["user"] != null ? Session["user"].ToString() : "";
            string q = "select top 1 * from Orders order by OrderId desc";
            if (!string.IsNullOrEmpty(user))
            {
                q = "select top 1 * from Orders where CustomerEmail='" + user + "' order by OrderId desc";
            }

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                lblOrderId.Text = r["OrderId"].ToString();
                lblCustomerName.Text = r["CustomerName"].ToString();
                lblTotalPrice.Text = r["TotalPrice"].ToString();
                lblOrderDate.Text = Convert.ToDateTime(r["OrderDate"]).ToString("dd-MM-yyyy hh:mm tt");
            }
        }
    }
}
