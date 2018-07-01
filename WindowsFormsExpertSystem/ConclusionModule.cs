using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsExpertSystem
{
    class ConclusionModule
    {
        private MainMenuWindow behind;

        public ConclusionModule(MainMenuWindow b)
        {
            this.behind = b;
        }

        public void Conclusion()
        {
            /* tworzymy joina z 3 datatables
             * select * from facts f
             * inner join FactsToConclusions ftc on f.Id = ftc.fact_id
             * inner join Conclusions c on c.Id = ftc.conclusion_id
             */
            DataTable ftc = new DataTable();
            DataTable c = new DataTable();

            SqlDataAdapter adp1 = new SqlDataAdapter("select * from FactsToConclusions", 
                this.behind.conn_MsSQL);
            SqlDataAdapter adp2 = new SqlDataAdapter("select * from Conclusions", 
                this.behind.conn_MsSQL);

            adp1.Fill(ftc);
            adp2.Fill(c);

            var join_tables = from fact in MainMenuWindow.tableFacts.AsEnumerable()
                              join fact_to_c in ftc.AsEnumerable() on fact["Id"] equals fact_to_c["fact_id"]
                              join conc in c.AsEnumerable() on fact_to_c["conclusion_id"] equals conc["Id"]
                              select new
                              {
                                  fact_id = (int)fact_to_c["fact_id"],
                                  conclusion_id = (int)fact_to_c["conclusion_id"],
                                  conclusion_name = (string)conc["conclusion_name"],
                                  value_should_be = (bool)fact_to_c["val"],
                                  value_is = (bool)fact["is_true"]
                              };

            /* Teraz zaczyna sie wnioskowanie */
            string konkluzja = "smierc naturalna";

            foreach (DataRow row in c.Rows)
            {
                var getOnlyMyFacts = from fact in join_tables
                                     where fact.conclusion_id == (int)row["Id"]
                                     select fact;
                bool flag = false;
                foreach (var item in getOnlyMyFacts)
                {
                    Console.WriteLine("--> Nazwa konkluzji: " + item.conclusion_name);
                    Console.WriteLine(item.value_is + " " + item.value_should_be);
                    if(item.value_is == item.value_should_be)
                    {
                        flag = true;
                    }
                    else
                    {
                        flag = false;
                        break;
                    }
                }
                if (flag)
                {
                    konkluzja = (string)row["conclusion_name"];
                    break;
                }
            }
            Console.WriteLine(konkluzja);
            new ConclusionBox(konkluzja).Show();
            /*dla kazdej przezslanki sprawdzamy czy fakty maja wartosci konieczne*/
        }
    }
}
