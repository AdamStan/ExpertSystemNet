using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsExpertSystem
{
    public partial class QuestionForm : Form
    {
        private string factName;
        private int index;

        public QuestionForm(string factName, string description, int id)
        {
            InitializeComponent();
            this.factName = factName;
            this.index = id;
            this.labelQuestion.Text = description; 
        }

        private void buttonYes_Click(object sender, EventArgs e)
        {
            MainMenuWindow.tableFacts.Rows[index - 1]["is_true"] = 1;
            this.Close();
        }

        private void buttonNo_Click(object sender, EventArgs e)
        {
            MainMenuWindow.tableFacts.Rows[index - 1]["is_true"] = 0;
            this.Close();
        }
    }
}
