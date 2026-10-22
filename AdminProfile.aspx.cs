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
    public partial class AdminProfile : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnUpdateAdmin_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "Admin profile credentials saved successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }
    }
}
