<%@ Page Title="مدیریت کارها" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="Work.aspx.cs" Inherits="Admin_Work" %>
<%@ Register Assembly="Heidarpour.WebControlUI" Namespace="Heidarpour.WebControlUI" TagPrefix="rhp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
     کارها
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    از طریق این صفحه می توانید  کار های به نمایش در آمده در صفحه اصلی را مدیریت نمایید. 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">        
    <script lang="jv" type="text/javascript">
        function SelectItem(sender, e) {
            e.IsValid = (e.Value != '0'); 7
        }
    </script>
    <asp:MultiView runat="server" ID="WorkMultiView" ActiveViewIndex="0">
        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="NewImageButton" runat="server" OnClick="NewImageButton_Click" SkinID="PanelAddImageButton" />
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
              <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="NameLabel" runat="server" Text="عنوان کار:" SkinID="Caption" ></asp:Label>
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
            <asp:GridView ID="WorkGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Id" DataSourceID="WorkEntityDataSource" HorizontalAlign="Center"
                OnSelectedIndexChanged="WorkGridView_SelectedIndexChanged" PageSize="5" Width="90%" AllowSorting="True" AllowPaging="True">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                                   <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                        </ItemTemplate>
                        <ItemStyle Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Id" Visible="False" SortExpression="Id"/>
                    <asp:BoundField DataField="Title" HeaderText="عنوان کار" >
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="WorkFormView" runat="server"  Width="90%" DataSourceID="WorkEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="WorkFormView_ItemDeleted"
                OnItemCommand="WorkFormView_ItemCommand">
                <EditItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="256" />
                    <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                     <br/>
                    <asp:Label ID="PictureLabel" runat="server" Text="تصویر:" SkinID="Caption" ></asp:Label>
                    <asp:FileUpload ID="PictureFileUpload" runat="server" />
                    <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر تصویر" />
                    <br />
                    
                    <asp:Label ID="StartDateLabel" runat="server" Text="تاریخ شروع:" SkinID="Caption"></asp:Label>
                    <rhp:DatePicker Date='<%# Bind("StartDate") %>' title="تاریخ شروع را وارد کنید" name="تاریخ شروع" placeholder="تاریخ را انتخاب کنید" ID="StartDateCalendar" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    <br />       

                    <asp:Label ID="EndDateLabel" runat="server" Text="تاریخ پایان:" SkinID="Caption"></asp:Label>
                    <rhp:DatePicker Date='<%# Bind("EndDate") %>' title="تاریخ پایان را وارد کنید" name="تاریخ پایان" placeholder="تاریخ را انتخاب کنید" ID="EndDateCalendar" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    <br /> 

                    <asp:Label ID="DescriptionLabel" runat="server" Text="متن:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Width="90%" />
                    <asp:RequiredFieldValidator ID="WorkRequiredFieldValidator" runat="server" ControlToValidate="DescriptionTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
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
                    <asp:ValidationSummary runat="server" ID="ghg" />
                    <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption" ></asp:Label>
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="256" />
                    <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    <br/>
                    <asp:Label ID="PictureLabel" runat="server" Text="تصویر:" SkinID="Caption" ></asp:Label>
                    <asp:FileUpload ID="PictureFileUpload" runat="server" />
                    <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر تصویر" />
                    <br />

                    <asp:Label ID="StartDateLabel" runat="server" Text="تاریخ شروع:" SkinID="Caption"></asp:Label>
                    <rhp:DatePicker Date='<%# Bind("StartDate") %>' title="تاریخ شروع را وارد کنید" name="تاریخ شروع" placeholder="تاریخ را انتخاب کنید" ID="StartDateCalendar" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    <br />       

                    <asp:Label ID="EndDateLabel" runat="server" Text="تاریخ پایان:" SkinID="Caption"></asp:Label>
                    <rhp:DatePicker Date='<%# Bind("EndDate") %>' title="تاریخ پایان را وارد کنید" name="تاریخ پایان" placeholder="تاریخ را انتخاب کنید" ID="EndDateCalendar" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    <br /> 

                    <asp:Label ID="DescriptionLabel" runat="server" Text="متن:" SkinID="Caption" ></asp:Label>
                    
                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Width="90%" />

                    <asp:RequiredFieldValidator ID="WorkRequiredFieldValidator" runat="server" ControlToValidate="DescriptionTextBox"
                        Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    <br />
                   
                    <div style="float: left; padding: 10px;">
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد"
                            ValidationGroup="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="انصراف" />
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <ef:EntityDataSource ID="WorkEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="Works"
        EnableUpdate="True"
        EnableDelete="True"
        EnableInsert="True"
        OnDeleted="WorkEntityDataSource_Command"
        OnInserted="WorkEntityDataSource_Command"
        OnUpdated="WorkEntityDataSource_Command"
        OnInserting="WorkEntityDataSource_InsertingFiles"
        OnUpdating="WorkEntityDataSource_InsertingFiles"
         OrderBy=" it.[ID] desc"  EnableFlattening="False"   
        Where="(@Title is null || it.Title LIKE '%' + @Title + '%')" >
        <WhereParameters>
            <asp:ControlParameter ControlID="TitleTextBox" Name="Title" Type="String" />
        </WhereParameters>
    </ef:EntityDataSource> 

</asp:Content>


