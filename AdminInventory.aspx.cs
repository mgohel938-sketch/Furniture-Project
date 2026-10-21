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
    public partial class AdminInventory : System.Web.UI.Page
    {
        protected GridView GridViewInventory;

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
            da = new SqlDataAdapter("select Id, ProductName, Category, Price, Stock from Products order by Stock asc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewInventory.DataSource = ds;
            GridViewInventory.DataBind();
        }
    }
}
