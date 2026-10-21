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
    public partial class AdminCategories : System.Web.UI.Page
    {
        protected GridView GridViewCategories;

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
            da = new SqlDataAdapter("select Category, count(*) as ProdCount from Products group by Category", con);
            ds = new DataSet();
            da.Fill(ds);
            GridViewCategories.DataSource = ds;
            GridViewCategories.DataBind();
        }
    }
}
