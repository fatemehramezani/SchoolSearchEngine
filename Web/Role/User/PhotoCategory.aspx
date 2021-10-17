<%@ Page Title="مدیریت آلبوم تصاویر" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="PhotoCategory.aspx.cs" Inherits="Admin_PhotoCategory" %>

<%@ Register Assembly="Heidarpour.WebControlUI" Namespace="Heidarpour.WebControlUI" TagPrefix="rhp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitleContent" runat="Server">
    آلبوم تصاویر
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید دسته بندی های مختلف را اضافه یا ویرایش کنید.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script lang="jv" type="text/javascript">
        function SelectItem(sender, e) {
            e.IsValid = (e.Value != '0');
        }
    </script>

    <asp:MultiView runat="server" ID="PhotoCategoryMultiView" ActiveViewIndex="0">
        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="NewImageButton" runat="server" OnClick="NewImageButton_Click" SkinID="PanelAddImageButton" />
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
            <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="TitleLabel" runat="server" Text="عنوان آلبوم:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="TitleTextBox" runat="server" SkinID="TextBox"></asp:TextBox>
            <br />
            <asp:Label ID="SizePageLabel" runat="server" Text="سایز صفحه:" SkinID="Caption"></asp:Label>
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

            <asp:GridView ID="PhotoCategoryGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Id" DataSourceID="PhotoCategoryEntityDataSource" HorizontalAlign="Center"
                PageSize="5" Width="90%" AllowSorting="True" AllowPaging="True" OnSelectedIndexChanged="PhotoCategoryGridView_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                        </ItemTemplate>
                        <ItemStyle Width="25px" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="ID" Visible="False" SortExpression="ID" />
                    <asp:BoundField DataField="Title" HeaderText="عنوان">
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="تاریخ">
                        <ItemTemplate>
                            <pdc:PersianDateLabel ID="DatePersianDateTextBox" runat="server" DateValue='<%# Bind("Date") %>'
                                PickerDirection="ToRight" ShowPickerOnTop="True" Width="90px"></pdc:PersianDateLabel>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="اضافه کردن تصویر">
                        <ItemTemplate>
                            <asp:ImageButton ID="PhotoCategoryFilesImageButton" runat="server" OnClick="PhotoCategoryFilesImageButton_Click" AlternateText='<%# Bind("Id") %>' ImageUrl="~/App_Themes/Panel/images/new-btn.png" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="PhotoCategoryFormView" runat="server" Width="90%" DataSourceID="PhotoCategoryEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="PhotoCategoryFormView_ItemDeleted"
                OnItemCommand="PhotoCategoryFormView_ItemCommand">
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="عنوان:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="500" />
                        <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="SchoolLabel" runat="server" Text="مدرسه:" SkinID="Caption"></asp:Label>                        
                        <asp:DropDownList ID="SchoolId" CssClass="form-control dropdown" SelectedValue='<%# Bind("SchoolId")%>' runat="server" DataSourceID="SchoolEntityDataSource" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True">
                            <asp:ListItem Value="" Selected="True">[ مدرسه خود را انتخاب کنید]</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="row">
                        <asp:Label ID="DateLabel" runat="server" Text="تاریخ:" SkinID="Caption"></asp:Label>
                        <rhp:DatePicker Date='<%# Bind("Date") %>' title="تاریخ را وارد کنید" name="تاریخ" placeholder="تاریخ را انتخاب کنید" ID="StartDateCalendar" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                                ValidationGroup="Update" OnClientClick="if (!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" />
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="Label2" runat="server" Text="عنوان:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="500" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TitleTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="SchoolLabel" runat="server" Text="مدرسه:" SkinID="Caption"></asp:Label>                        
                        <asp:DropDownList ID="SchoolId" CssClass="form-control dropdown" SelectedValue='<%# Bind("SchoolId")%>' runat="server" DataSourceID="SchoolEntityDataSource" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True" Width="90%">
                            <asp:ListItem Value="" Selected="True">[ مدرسه خود را انتخاب کنید]</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="row">
                        <asp:Label ID="Label3" runat="server" Text="تاریخ:" SkinID="Caption"></asp:Label>
                        <rhp:DatePicker Date='<%# Bind("Date") %>' title="تاریخ را وارد کنید" name="تاریخ" placeholder="تاریخ را انتخاب کنید" ID="DatePicker1" runat="server" CalendarType="Persian" ReadOnly="false" FirstDayOfWeek="Saturday" ShowOthers="True"></rhp:DatePicker>
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد"
                                ValidationGroup="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="انصراف" />
                        </div>
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <ef:EntityDataSource ID="PhotoCategoryEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities" DefaultContainerName="DatabaseEntities" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="PhotoCategory"
        OnDeleted="PhotoCategoryEntityDataSource_Command"
        OnInserted="PhotoCategoryEntityDataSource_Command"
        OnUpdated="PhotoCategoryEntityDataSource_Command"
        OnInserting="PhotoCategoryEntityDataSource_Commanding"
        OnUpdating="PhotoCategoryEntityDataSource_Commanding"
        AutoGenerateOrderByClause="True"
        Where="(@Title is null || it.Title LIKE '%' + @Title + '%') && (@ApplicantId is null || it.ApplicantId = @ApplicantId)">
        <WhereParameters>
            <asp:ControlParameter ControlID="TitleTextBox" Name="Title" Type="String" />
            <asp:ProfileParameter PropertyName="ApplicantId" Name="ApplicantId" Type="Int32" />
        </WhereParameters>
        <OrderByParameters>
            <asp:ControlParameter ControlID="PhotoCategoryGridView" Name="OrderBy" PropertyName="SortExpression"
                Type="String" />
        </OrderByParameters>
    </ef:EntityDataSource>
    <ef:EntityDataSource ID="SchoolEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="Information"
        Where="it.ApplicantId = @ApplicantId">
        <WhereParameters>
            <asp:ProfileParameter PropertyName="ApplicantId" Name="ApplicantId" Type="Int32" />
        </WhereParameters>
    </ef:EntityDataSource>
    <pdc:PersianDateScriptManager ID="PersianDateScriptManager" runat="server">
    </pdc:PersianDateScriptManager>
</asp:Content>

