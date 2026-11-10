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
            cmd = new SqlCommand("delete from OrderDetails where OrderId='" + orderId + "'; delete from Orders where OrderId='" + orderId + "';", con);
            cmd.ExecuteNonQuery();
            gridfill();
        }

        protected void GridViewOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlChangeStatus");
                if (ddl != null)
                {
                    string status = DataBinder.Eval(e.Row.DataItem, "Status") != null ? DataBinder.Eval(e.Row.DataItem, "Status").ToString() : "Pending";
                    ListItem item = ddl.Items.FindByValue(status);
                    if (item != null)
                    {
                        ddl.ClearSelection();
                        item.Selected = true;
                    }
                }
            }
        }

        protected void ddlChangeStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;
            int orderId = Convert.ToInt32(GridViewOrders.DataKeys[row.RowIndex].Value);
            string newStatus = ddl.SelectedValue;

            getcon();
            cmd = new SqlCommand("update Orders set Status='" + newStatus + "' where OrderId='" + orderId + "'", con);
            cmd.ExecuteNonQuery();
            gridfill();
        }
    }
}
