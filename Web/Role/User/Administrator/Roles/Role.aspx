<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="Role.aspx.cs" Inherits="Admin_Roles_Role" Title="نقش کاربران" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید نقش کاربران را مشخص کنید.
</asp:Content>        
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="pages-content">
        <h1>نقش کاربران</h1>
        <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td style="padding: 10px 50px;">
                    <table width="100%" border="0" cellpadding="0" cellspacing="10">
                        <tr>
                            <td width="50%">
                                <h3>حذف نقش</h3>
                                <asp:GridView SkinID="PanelGridView"  ID="RoleList" runat="server" AutoGenerateColumns="False" OnRowDeleting="RoleList_RowDeleting">
                                    <Columns>
                                        <asp:CommandField DeleteText="حذف" ShowDeleteButton="True" />
                                        <asp:TemplateField HeaderText="نقش">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="RoleNameLabel" Text='<%# Container.DataItem %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td width="50%">
                                <h3>ایجاد نقش جدید</h3>
                                <asp:Label ID="RoleLabel" runat="server">ایجاد نقش جدید: </asp:Label>
                                <asp:TextBox ID="RoleName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RoleNameReqField" runat="server"
                                    ControlToValidate="RoleName" Display="Dynamic"
                                    ErrorMessage="نقش اجباری">*</asp:RequiredFieldValidator>
                                <br />
                                <div dir="ltr">
                                    <asp:Button ID="CreateRoleButton" runat="server" Text="ایجاد نقش"
                                        OnClick="CreateRoleButton_Click" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

