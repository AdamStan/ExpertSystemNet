using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace WindowsFormsExpertSystem
{
    public partial class MainMenuWindow : Form
    {
        public SqlConnection conn_MsSQL;

        public static DataTable tableFacts;

        public MainMenuWindow()
        {
            InitializeComponent();
            conn_MsSQL = new SqlConnection();
            conn_MsSQL.ConnectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;" +
                "AttachDbFilename=B:\\Projects\\C#\\ExpertSystem\\WindowsFormsExpertSystem" +
                "\\KnowledgeBase.mdf;Integrated Security=True";
        }
        

        private void buttonExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void buttonStart_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.getTable("Facts");
            new QuestionsController(this);
        }
        public void getTable(string name)
        {
            conn_MsSQL.Open();
            tableFacts = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter("select * from "
                + name, conn_MsSQL);
            sda.Fill(tableFacts);
            conn_MsSQL.Close();
        }
        public void commitTable()
        {
            tableFacts.AcceptChanges();
            conn_MsSQL.Open();
            SqlDataAdapter sda = new SqlDataAdapter("select * from Facts", this.conn_MsSQL);
            sda.Update(tableFacts);
            conn_MsSQL.Close();
        }
        public void resetValuesInDatabase()
        {
            DataRowCollection wiersze = tableFacts.Rows;
            DataColumnCollection columny = tableFacts.Columns;
            foreach (DataRow row in wiersze)
            {
                StringBuilder buff = new StringBuilder();
                foreach (DataColumn col in columny)
                {
                    buff.Append(row[col] + " | ");
                }
                row["is_true"] = DBNull.Value;
                buff.Append(" Now is_true have value : " + row["is_true"]);
                Console.WriteLine(buff.ToString());
            }
        }

        private void buttonEditBase_Click(object sender, EventArgs e)
        {
            try
            {
                this.resetValuesInDatabase();
            }
            catch(NullReferenceException ex)
            {
                MessageBox.Show("Najpierw trzeba wystartować, później można czyścić");
            }
        }
    }
}
