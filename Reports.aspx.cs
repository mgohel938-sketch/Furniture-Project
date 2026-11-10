using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

namespace FurniShop
{
    public partial class Reports : System.Web.UI.Page
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

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        protected void Page_Init(object sender, EventArgs e)
        {
            // Re-bind report in Page_Init on postback so CrystalReportViewer maintains state
            if (Session["ReportDoc"] != null)
            {
                cr = (ReportDocument)Session["ReportDoc"];
                CrystalReportViewer1.ReportSource = cr;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                DateTime today = DateTime.Today;
                txtFromDate.Text = new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd");
                txtToDate.Text = today.ToString("yyyy-MM-dd");

                UpdateFilterVisibility();
            }
        }

        protected void ddlReport_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateFilterVisibility();
            pnlMessage.Visible = false;
            CrystalReportViewer1.ReportSource = null;
            Session["ActiveReport"] = null;

            if (Session["ReportDoc"] != null)
            {
                ReportDocument oldCr = Session["ReportDoc"] as ReportDocument;
                if (oldCr != null)
                {
                    oldCr.Close();
                    oldCr.Dispose();
                }
                Session["ReportDoc"] = null;
            }
        }

        private void UpdateFilterVisibility()
        {
            string selected = ddlReport.SelectedValue;
            pnlStockLimit.Visible = (selected == "LowStockReport");
            pnlBillId.Visible = (selected == "InvoiceReport");
            pnlFromDate.Visible = (selected == "SalesReport");
            pnlToDate.Visible = (selected == "SalesReport");
            pnlStatus.Visible = (selected == "OrderStatusReport");
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            Session["ActiveReport"] = ddlReport.SelectedValue;
            BindReport(false);
        }

        protected void btnDownloadPdf_Click(object sender, EventArgs e)
        {
            BindReport(true);
        }

        private void GetData(string reportName)
        {
            switch (reportName)
            {
                case "ProductListReport":
                    getcon();
                    da = new SqlDataAdapter("SELECT Id, ProductName, Category, Price, Stock FROM Products ORDER BY ProductName ASC", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "ProductListReport";
                    con.Close();
                    break;

                case "CategoryWiseProductReport":
                    getcon();
                    da = new SqlDataAdapter("SELECT Category, ProductName, Price, Stock FROM Products ORDER BY Category ASC, ProductName ASC", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "CategoryWiseProductReport";
                    con.Close();
                    break;

                case "LowStockReport":
                    int limit = 5;
                    int.TryParse(txtStockLimit.Text.Trim(), out limit);
                    getcon();
                    cmd = new SqlCommand("SELECT Id, ProductName, Category, Price, Stock FROM Products WHERE Stock <= @limit ORDER BY Stock ASC", con);
                    cmd.Parameters.AddWithValue("@limit", limit);
                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "LowStockReport";
                    con.Close();
                    break;

                case "InvoiceReport":
                    int billId = 0;
                    if (!int.TryParse(txtBillId.Text.Trim(), out billId) || billId <= 0)
                    {
                        ShowMessage("Please enter a valid numeric Bill / Order ID.", false);
                        ds = null;
                        return;
                    }
                    getcon();
                    string qInvoice = @"SELECT o.OrderId, o.OrderDate, o.TotalPrice, o.Status, o.PaymentMethod,
                                               o.Address, o.CustomerName, o.CustomerEmail,
                                               d.ProductName, d.Price, d.Quantity, d.Total
                                        FROM Orders o
                                        LEFT JOIN OrderDetails d ON o.OrderId = d.OrderId
                                        WHERE o.OrderId = @billId";
                    cmd = new SqlCommand(qInvoice, con);
                    cmd.Parameters.AddWithValue("@billId", billId);
                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "InvoiceReport";
                    con.Close();
                    break;

                case "SalesReport":
                    DateTime fromDate, toDate;
                    if (!DateTime.TryParse(txtFromDate.Text.Trim(), out fromDate)) fromDate = new DateTime(2000, 1, 1);
                    if (!DateTime.TryParse(txtToDate.Text.Trim(), out toDate)) toDate = DateTime.Today;
                    toDate = toDate.Date.AddDays(1).AddTicks(-1);
                    getcon();
                    string qSales = @"SELECT o.OrderId, o.OrderDate, o.CustomerName, o.PaymentMethod, o.TotalPrice, o.Status
                                      FROM Orders o
                                      WHERE o.OrderDate >= @fromDate AND o.OrderDate <= @toDate
                                      ORDER BY o.OrderDate DESC";
                    cmd = new SqlCommand(qSales, con);
                    cmd.Parameters.AddWithValue("@fromDate", fromDate);
                    cmd.Parameters.AddWithValue("@toDate", toDate);
                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "SalesReport";
                    con.Close();
                    break;

                case "CustomerWiseSalesReport":
                    getcon();
                    string qCust = @"SELECT o.CustomerName, o.CustomerEmail,
                                            COUNT(o.OrderId) AS OrdersCount,
                                            ISNULL(SUM(o.TotalPrice), 0) AS TotalSpent
                                     FROM Orders o
                                     GROUP BY o.CustomerName, o.CustomerEmail
                                     ORDER BY TotalSpent DESC";
                    da = new SqlDataAdapter(qCust, con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "CustomerWiseSalesReport";
                    con.Close();
                    break;

                case "OrderStatusReport":
                    getcon();
                    string qStatus = @"SELECT o.OrderId, o.OrderDate, o.CustomerName, o.TotalPrice, o.PaymentMethod, o.Status
                                       FROM Orders o";
                    if (!string.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "All")
                    {
                        qStatus += " WHERE o.Status = @status";
                    }
                    qStatus += " ORDER BY o.OrderDate DESC";
                    cmd = new SqlCommand(qStatus, con);
                    if (!string.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "All")
                    {
                        cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                    }
                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0) ds.Tables[0].TableName = "OrderStatusReport";
                    con.Close();
                    break;
            }
        }

        private void BindReport(bool isPdfExport)
        {
            pnlMessage.Visible = false;
            string reportName = ddlReport.SelectedValue;

            GetData(reportName);
            if (ds == null) return;

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                CrystalReportViewer1.ReportSource = null;
                Session["ActiveReport"] = null;
                ShowMessage("No data found for the selected criteria.", false);
                return;
            }

            Crypath = Server.MapPath("~/CrystalReports/" + reportName + ".rpt");
            if (!File.Exists(Crypath))
            {
                CrystalReportViewer1.ReportSource = null;
                ShowMessage("Crystal Report file '" + reportName + ".rpt' was not found in ~/CrystalReports/ folder. Please design and place the .rpt file using the XML schema.", false);
                return;
            }

            try
            {
                if (Session["ReportDoc"] != null)
                {
                    ReportDocument oldCr = Session["ReportDoc"] as ReportDocument;
                    if (oldCr != null)
                    {
                        oldCr.Close();
                        oldCr.Dispose();
                    }
                }

                cr = new ReportDocument();
                cr.Load(Crypath);
                cr.SetDataSource(ds.Tables[0]);
                cr.Refresh();

                Session["ReportDoc"] = cr;
                CrystalReportViewer1.ReportSource = cr;
                CrystalReportViewer1.DataBind();

                if (isPdfExport)
                {
                    cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, reportName);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Report Error: " + ex.Message, false);
            }
        }

        protected void btnGenerateSchemas_Click(object sender, EventArgs e)
        {
            try
            {
                string schemaDir = Server.MapPath("~/XmlSchemas");
                if (!Directory.Exists(schemaDir))
                {
                    Directory.CreateDirectory(schemaDir);
                }

                // 1. ProductListReport
                getcon();
                da = new SqlDataAdapter("SELECT Id, ProductName, Category, Price, Stock FROM Products ORDER BY ProductName ASC", con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "ProductListReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "ProductListReport.xml"));
                con.Close();

                // 2. CategoryWiseProductReport
                getcon();
                da = new SqlDataAdapter("SELECT Category, ProductName, Price, Stock FROM Products ORDER BY Category ASC, ProductName ASC", con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "CategoryWiseProductReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "CategoryWiseProductReport.xml"));
                con.Close();

                // 3. LowStockReport
                getcon();
                da = new SqlDataAdapter("SELECT Id, ProductName, Category, Price, Stock FROM Products WHERE Stock <= 1000 ORDER BY Stock ASC", con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "LowStockReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "LowStockReport.xml"));
                con.Close();

                // 4. InvoiceReport
                getcon();
                string qInvoice = @"SELECT o.OrderId, o.OrderDate, o.TotalPrice, o.Status, o.PaymentMethod,
                                           o.Address, o.CustomerName, o.CustomerEmail,
                                           d.ProductName, d.Price, d.Quantity, d.Total
                                    FROM Orders o
                                    LEFT JOIN OrderDetails d ON o.OrderId = d.OrderId";
                da = new SqlDataAdapter(qInvoice, con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "InvoiceReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "InvoiceReport.xml"));
                con.Close();

                // 5. SalesReport
                getcon();
                string qSales = @"SELECT o.OrderId, o.OrderDate, o.CustomerName, o.PaymentMethod, o.TotalPrice, o.Status
                                  FROM Orders o
                                  ORDER BY o.OrderDate DESC";
                da = new SqlDataAdapter(qSales, con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "SalesReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "SalesReport.xml"));
                con.Close();

                // 6. CustomerWiseSalesReport
                getcon();
                string qCust = @"SELECT o.CustomerName, o.CustomerEmail,
                                        COUNT(o.OrderId) AS OrdersCount,
                                        ISNULL(SUM(o.TotalPrice), 0) AS TotalSpent
                                 FROM Orders o
                                 GROUP BY o.CustomerName, o.CustomerEmail
                                 ORDER BY TotalSpent DESC";
                da = new SqlDataAdapter(qCust, con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "CustomerWiseSalesReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "CustomerWiseSalesReport.xml"));
                con.Close();

                // 7. OrderStatusReport
                getcon();
                string qStatus = @"SELECT o.OrderId, o.OrderDate, o.CustomerName, o.TotalPrice, o.PaymentMethod, o.Status
                                   FROM Orders o
                                   ORDER BY o.OrderDate DESC";
                da = new SqlDataAdapter(qStatus, con);
                ds = new DataSet();
                da.Fill(ds);
                ds.Tables[0].TableName = "OrderStatusReport";
                ds.WriteXmlSchema(Path.Combine(schemaDir, "OrderStatusReport.xml"));
                con.Close();

                ShowMessage("Successfully generated all 7 XML schema files in ~/XmlSchemas/ folder!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error generating XML schemas: " + ex.Message, false);
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = msg;
            divMsg.Attributes["class"] = isSuccess ? "alert-box alert-success" : "alert-box alert-warning";
        }
    }
}
