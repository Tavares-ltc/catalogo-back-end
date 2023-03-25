-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '16:38:05.628232-03'::time with time zone,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Admin_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Images" (
    "id" SERIAL NOT NULL,
    "link" TEXT NOT NULL,
    "product_id" INTEGER NOT NULL,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '16:38:05.628232-03'::time with time zone,
    "created_by" INTEGER NOT NULL,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Images_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "discount_percentage" INTEGER NOT NULL DEFAULT 0,
    "units" INTEGER NOT NULL,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '16:38:05.628232-03'::time with time zone,
    "created_by" INTEGER NOT NULL,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Product_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sessions" (
    "id" SERIAL NOT NULL,
    "admin_id" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '20:50:43.291683-03'::time with time zone,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Sessions_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wishlist" (
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '16:38:05.628232-03'::time with time zone,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Wishlist_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "client" VARCHAR(255) NOT NULL,
    "payment_id" INTEGER NOT NULL,
    "concluded" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMETZ(6) NOT NULL DEFAULT '16:38:05.628232-03'::time with time zone,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Order_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Payment_pk" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Images" ADD CONSTRAINT "Images_fk0" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Images" ADD CONSTRAINT "Images_fk1" FOREIGN KEY ("created_by") REFERENCES "Admin"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_fk0" FOREIGN KEY ("created_by") REFERENCES "Admin"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Sessions" ADD CONSTRAINT "Sessions_fk0" FOREIGN KEY ("admin_id") REFERENCES "Admin"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Wishlist" ADD CONSTRAINT "Wishlist_fk0" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Wishlist" ADD CONSTRAINT "Wishlist_fk1" FOREIGN KEY ("order_id") REFERENCES "Order"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_fk0" FOREIGN KEY ("payment_id") REFERENCES "Payment"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
