using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;

namespace WindowsFormsExpertSystem
{
    class QuestionsController
    {
        public QuestionsController(MainMenuWindow behind)
        {
            foreach(DataRow r in MainMenuWindow.tableFacts.Rows)
            {
                string factName = (string)r["fact_name"];
                string desc = (string) r["fact_description"];
                int index = (int)r["Id"];
                new QuestionForm(factName, desc, index).ShowDialog();
            }
            behind.Show();
            new ConclusionModule(behind).Conclusion();
        }
    }
}
