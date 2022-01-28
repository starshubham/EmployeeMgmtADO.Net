using EmployeeManagement;
using EmployeeManagement.Model;
using EmployeeManagement.Model.SalaryModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace EmployeeMangementTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void GivenSalaryDetails_AbleToUpdateSalaryDetails()
        {
            //Arrange
            Salary salary = new Salary();
            SalaryUpdateModel updateModel = new SalaryUpdateModel()
            {
                SalaryId = 2,
                Month = "Jan",
                EmployeeSalary = 400000,
                EmployeeId = 5
            };

            //Act
            int EmpSalary = salary.UpdateEmployeeSalary(updateModel);

            //Assert
            Assert.AreEqual(updateModel.EmployeeSalary, EmpSalary);
        }
    }
}
