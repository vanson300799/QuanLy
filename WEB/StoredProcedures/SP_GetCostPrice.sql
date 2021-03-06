USE [Petro]
GO
/****** Object:  StoredProcedure [dbo].[GetCostPrice]    Script Date: 1/14/2021 9:58:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCostPrice]
@ProductId int,
@StationId int,
@QuantityRequired int
AS
	BEGIN
		SELECT iod.*,0 as 'Processed', InputNumber AS 'AvailableQuantity'
		INTO #Temp
		FROM ImportOrderDetail iod
			JOIN ImportOrder ior on iod.ParrentID = ior.ID
		WHERE 
			iod.IsActive = 1
			AND ior.IsActive = 1
			AND ProductId = @ProductId 
			AND iod.StationID = @StationId

		IF (SELECT COUNT(*) FROM #Temp) = 0
			RETURN

		--Loop
		Declare @Id int
		Declare @TotalImported int
		Declare @TotalSale int
		Declare @Found bit = 0
		Declare @RequiredAmountLeft INT = 0

		-- get total sale
		SELECT @RequiredAmountLeft = SUM(SaleAmount)
			FROM InvoiceDetail ivd
			JOIN Invoice iv on ivd.ParrentID = iv.ID
		WHERE 
			ivd.IsActive = 1
			AND iv.IsActive = 1 
			AND ProductID = @ProductId 
			AND ivd.StationID = @StationId

		SET @TotalImported = 0

		While (@RequiredAmountLeft > 0 AND EXISTS (SELECT * FROM #Temp WHERE Processed = 0))
		Begin
			Select Top 1 @Id = Id, @TotalImported = @TotalImported+ InputNumber, 
			@RequiredAmountLeft = @RequiredAmountLeft - InputNumber  From #Temp Where Processed = 0
			ORDER BY [Date]
	
			IF @RequiredAmountLeft <= 0
				BEGIN 
					UPDATE #Temp
					SET AvailableQuantity =  -@RequiredAmountLeft
					WHERE ID = @Id
				END
			ELSE
				UPDATE #Temp
				SET AvailableQuantity = 0
				WHERE ID = @Id

			Update #Temp Set Processed = 1 Where Id = @Id 
		End

		-- SELECT
		select
			i.ID as 'ImportOrderId',
			i.InputPrice as 'Price',
			case
				when
					@QuantityRequired - 
					isnull(
						(
							select
								sum(AvailableQuantity)
							from
								 #Temp i2
							where
								i2.ProductID = i.ProductID
								and i2.[Date] < i.[Date]
						),
						0) < i.InputNumber
				then
					@QuantityRequired - 
					isnull(
						(
							select
								sum(AvailableQuantity)
							from
								#Temp i2
							where
								i2.ProductID = i.ProductID
								and i2.[Date] < i.[Date]
						),
						0)
				else
					i.AvailableQuantity
			end as 'QuantityTaken'
		from 
			#Temp i
		where   
			i.ProductID = @ProductId
			and 
			case
				when
					@QuantityRequired - 
					isnull(
						(
							select
								sum(AvailableQuantity)
							from
								 #Temp i2
							where
								i2.ProductID = i.ProductID
								and i2.[Date] < i.[Date]
						),
						0) < i.InputNumber
				then
					@QuantityRequired - 
					isnull(
						(
							select
								sum(AvailableQuantity)
							from
								 #Temp i2
							where
								i2.ProductID = i.ProductID
								and i2.[Date] < i.[Date]
						),
						0)
				else
					i.AvailableQuantity
				end > 0
				DROP TABLE #Temp
	END 
