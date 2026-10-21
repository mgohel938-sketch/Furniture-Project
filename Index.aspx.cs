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
    public partial class Index : System.Web.UI.Page
    {
        protected Repeater rptrFeatured;

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
                fillFeaturedProducts();
            }
        }

        void fillFeaturedProducts()
        {
            getcon();
            da = new SqlDataAdapter("select top 8 * from Products order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            rptrFeatured.DataSource = ds;
            rptrFeatured.DataBind();
        }
    }
}
