<%@ Page Title="مدیریت صفحات پویا" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="DynamicPage.aspx.cs" Inherits="Admin_DynamicPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
     مدیریت صفحات پویا
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    از طریق این صفحه می توانید صفحات پویا به نمایش در آمده در صفحه اصلی را مدیریت نمایید. 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">  
    <script lang="jv" type="text/javascript">
        function SelectItem(sender, e) {
            e.IsValid = (e.Value != '0'); 7
        }
    </script>
    <asp:MultiView runat="server" ID="DynamicPageMultiView" ActiveViewIndex="0">

        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="NewImageButton" runat="server" OnClick="NewImageButton_Click" SkinID="PanelAddImageButton" />
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
              <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="NameLabel" runat="server" Text="عنوان صفحه:" SkinID="Caption" ></asp:Label>
            <asp:TextBox ID="TitleTextBox" runat="server" SkinID="TextBox"></asp:TextBox>
             <br />
            <asp:Label ID="SizePageLabel" runat="server" Text="سایز صفحه:" SkinID="Caption" ></asp:Label>
            <asp:DropDownList ID="PageSizeDropDownList" SkinID="SearchDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="5">[پیش فرض]</asp:ListItem>
                <asp:ListItem Value="5">5 رکورد</asp:ListItem>
                <asp:ListItem Value="10">10 رکورد</asp:ListItem>
                <asp:ListItem Value="15">15 رکورد</asp:ListItem>
                <asp:ListItem Value="20">20 رکورد</asp:ListItem>
                <asp:ListItem Value="25">25 رکورد</asp:ListItem>
                <asp:ListItem Value="1000000">تمام رکورد ها</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:GridView ID="DynamicPageGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Id" DataSourceID="DynamicPageEntityDataSource" HorizontalAlign="Center"
                OnSelectedIndexChanged="DynamicPageGridView_SelectedIndexChanged" PageSize="5" Width="90%" AllowSorting="True" AllowPaging="True">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                                   <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                        </ItemTemplate>
                        <ItemStyle Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Id" Visible="False" SortExpression="Id"/>
                    <asp:BoundField DataField="Title" HeaderText="عنوان صفحه" >
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                       <asp:BoundField DataField="Name" HeaderText="نام صفحه" >
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="DynamicPageFormView" runat="server"  Width="90%" DataSourceID="DynamicPageEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="DynamicPageFormView_ItemDeleted"
                OnItemCommand="DynamicPageFormView_ItemCommand">
                <EditItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="64" />
                    <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    <br/>
                    <asp:Label ID="NameLabel" runat="server" Text="نام:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="64" />
                    <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    <br/>
                    <asp:Label ID="PriorityLabel" runat="server" Text="اولویت منو:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="PriorityTextBox" runat="server" Text='<%# Bind("PriorityId") %>' MaxLength="2" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PriorityTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CheckBox ID="IsVisibleCheckBox" runat="server" Text="در منو نمایش داده شود" Checked='<%# Bind("IsVisible") %>'/>
                    <br />
                    <asp:Label ID="ContentLabel" runat="server" Text="متن:" SkinID="Caption" ></asp:Label>
                    <asp:CKEditor ID="ContentTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Content")%>' />                        
                    <br />
                    <div style="float: left; padding: 10px;">
                        <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                            Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" />
                        <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                            ValidationGroup="Update" OnClientClick="if (!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return false;" />
                        <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" />
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="64" />
                    <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="NameLabel" runat="server" Text="نام:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="64" />
                    <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    <br />
                    <asp:Label ID="PriorityLabel" runat="server" Text="اولویت منو:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="PriorityTextBox" runat="server" Text='<%# Bind("PriorityId") %>' MaxLength="2" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PriorityTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CheckBox ID="IsVisibleCheckBox" runat="server" Text="در منو نمایش داده شود" Checked='<%# Bind("IsVisible") %>'/>
                    <br />
                    <asp:Label ID="ContentLabel" runat="server" CssClass="speciallable" SkinID="Caption" Text="متن:"></asp:Label>
                    <asp:CKEditor ID="ContentTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Content")%>' />                        
                    <br />
                    <div style="float: left; padding: 10px;">
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد" ValidationGroup="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="انصراف" />
                    </div>
                    <br>
                    </br>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <ef:EntityDataSource ID="DynamicPageEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="DynamicPage"
        EnableUpdate="True"
        EnableDelete="True"
        EnableInsert="True"
        OnDeleted="DynamicPageEntityDataSource_Command"
        OnInserted="DynamicPageEntityDataSource_Command"
        OnUpdated="DynamicPageEntityDataSource_Command"
        OrderBy=" it.[Id] desc"  EnableFlattening="False"   
        Where="(@Title is null || it.Title LIKE '%' + @Title + '%')" >
        <WhereParameters>
            <asp:ControlParameter ControlID="TitleTextBox" Name="Title" Type="String" />
        </WhereParameters>
    </ef:EntityDataSource> 

</asp:Content>


