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
    public partial class AdminOrders : System.Web.UI.Page
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
                gridfill();
            }
        }

        void gridfill()
        {
            getcon();
            da = new SqlDataAdapter("select * from Orders order by OrderId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewOrders.DataSource = ds;
            GridViewOrders.DataBind();
        }

        protected void GridViewOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderId = Convert.ToInt32(GridViewOrders.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("delete from Orders where OrderId='" + orderId + "'", con);
            cmd.ExecuteNonQuery();
            gridfill();
        }
    }
}
