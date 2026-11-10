namespace FurniShop
{
    public partial class Reports
    {
        protected global::System.Web.UI.WebControls.Panel pnlMessage;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divMsg;
        protected global::System.Web.UI.WebControls.Label lblMessage;

        protected global::System.Web.UI.WebControls.DropDownList ddlReport;

        protected global::System.Web.UI.WebControls.Panel pnlStockLimit;
        protected global::System.Web.UI.WebControls.TextBox txtStockLimit;

        protected global::System.Web.UI.WebControls.Panel pnlBillId;
        protected global::System.Web.UI.WebControls.TextBox txtBillId;

        protected global::System.Web.UI.WebControls.Panel pnlFromDate;
        protected global::System.Web.UI.WebControls.TextBox txtFromDate;

        protected global::System.Web.UI.WebControls.Panel pnlToDate;
        protected global::System.Web.UI.WebControls.TextBox txtToDate;

        protected global::System.Web.UI.WebControls.Panel pnlStatus;
        protected global::System.Web.UI.WebControls.DropDownList ddlStatus;

        protected global::System.Web.UI.WebControls.Button btnShowReport;
        protected global::System.Web.UI.WebControls.Button btnDownloadPdf;
        protected global::System.Web.UI.WebControls.Button btnGenerateSchemas;

        protected global::CrystalDecisions.Web.CrystalReportViewer CrystalReportViewer1;
    }
}
