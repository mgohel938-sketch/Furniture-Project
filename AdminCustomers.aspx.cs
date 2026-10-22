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
    public partial class AdminCustomers : System.Web.UI.Page
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
            da = new SqlDataAdapter("select Id, Name, Email, Phone, CreatedDate from Users order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewCustomers.DataSource = ds;
            GridViewCustomers.DataBind();
        }

        protected void GridViewCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridViewCustomers.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("delete from Users where Id='" + id + "'", con);
            cmd.ExecuteNonQuery();
            gridfill();
        }
    }
}
